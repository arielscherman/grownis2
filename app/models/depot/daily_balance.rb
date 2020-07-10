class Depot::DailyBalance < ApplicationRecord
  belongs_to :previous_daily_balance, class_name: "Depot::DailyBalance", optional: true
  belongs_to :depot, inverse_of: :daily_balances

  before_create :calculate_balance
  before_update :calculate_balance, if: :cached_rate_value_changed?

  scope :for_user, ->(user) { joins(depot: :user).where(depots: { user: user }).merge(Depot.active) }

  class << self
    def consolidated_by_date
      consolidated = ConsolidatedByDate.new

      includes(depot: :currency).each { |daily_balance| consolidated.add(daily_balance) }

      consolidated.result
    end
  end

  def absolute_rate_value
    (1 / cached_rate_value).round(2)
  end

  def cents_in_usd
    depot.currency.usd? ? cached_depot_total_in_cents : cached_depot_total_by_rate_in_cents
  end

  def difference_cents_in_usd
    depot.currency.usd? ? cached_difference_in_cents : cached_difference_by_rate_in_cents
  end

  private

  def calculate_balance
    self.cached_depot_total_by_rate_in_cents     = convert(cached_depot_total_in_cents)
    self.cached_difference_in_cents              = difference.in_cents
    self.cached_difference_in_percentage         = difference.in_percentage
    self.cached_difference_by_rate_in_cents      = difference_by_rate.in_cents
    self.cached_difference_by_rate_in_percentage = difference_by_rate.in_percentage
  end

  def convert(value)
    difference_by_rate.convert(value)
  end

  def difference
    @difference ||= DifferenceCalculator.new(previous_daily_balance, self)
  end

  def difference_by_rate
    @difference_by_rate ||= DifferenceByRateCalculator.new(previous_daily_balance, self, cached_rate_value)
  end
end
