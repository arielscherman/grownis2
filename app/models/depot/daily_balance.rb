class Depot::DailyBalance < ApplicationRecord
  belongs_to :previous_daily_balance, class_name: "Depot::DailyBalance", optional: true
  belongs_to :depot

  before_create :calculate_balance
  before_update :calculate_balance, if: :cached_rate_value_changed?

  private

  def calculate_balance
    self.cached_depot_total_by_rate_in_cents     = depot_total_by_rate_in_cents
    self.cached_difference_in_cents              = previous_daily_balance ? difference_in_cents : 0
    self.cached_difference_in_percentage         = previous_daily_balance ? difference_in_percentage : 0.00
    self.cached_difference_by_rate_in_cents      = previous_daily_balance ? difference_by_rate_in_cents : 0
    self.cached_difference_by_rate_in_percentage = previous_daily_balance ? difference_by_rate_in_percentage : 0.00
  end

  def depot_total_by_rate_in_cents
    return if cached_rate_value.nil?
    cached_depot_total_in_cents * cached_rate_value
  end

  def difference_in_cents
    cached_depot_total_in_cents - previous_daily_balance.cached_depot_total_in_cents
  end

  # calculates yesterday's value by today's rate (ex: in usd) and does that minus
  # yesterday's value by yesterday's rate, to know the difference in that rate.
  #
  def difference_by_rate_in_cents
    return if cached_rate_value.nil?
    yesterday_value_by_todays_rate = previous_daily_balance.cached_depot_total_in_cents * cached_rate_value
    yesterday_value_by_todays_rate - previous_daily_balance.cached_depot_total_by_rate_in_cents 
  end

  def difference_by_rate_in_percentage
    return if cached_rate_value.nil?
    relative_diff = cached_depot_total_by_rate_in_cents / previous_daily_balance.cached_depot_total_by_rate_in_cents.to_f
    (relative_diff - 1) * 100
  end

  def difference_in_percentage
    relative_diff = cached_depot_total_in_cents / previous_daily_balance.cached_depot_total_in_cents.to_f
    (relative_diff - 1) * 100
  end
end
