class Depot::DailyBalance < ApplicationRecord
  belongs_to :previous_daily_balance, class_name: "Depot::DailyBalance", optional: true
  belongs_to :depot

  before_create :calculate_balance
  before_update :calculate_balance, if: :cached_rate_value_changed?

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
