require 'test_helper'

class Depot::DailyBalanceTest < ActiveSupport::TestCase
  def build_balance
    depot            = depots(:fresh)
    previous_balance = Depot::DailyBalance.create!(depot: depot,
                                                   date: 1.day.ago.to_date,
                                                   cached_depot_total_in_cents: 15_000_00,
                                                   cached_rate_value: 1/115.0)
    current_balance  = Depot::DailyBalance.create!(depot: depot,
                                                   previous_daily_balance: previous_balance,
                                                   date: Time.zone.today,
                                                   cached_depot_total_in_cents: 16_000_00,
                                                   cached_rate_value: 1/120.0)

    current_balance
  end

  def test_for_user_does_not_include_inactive_depots_balances
    depot = depots(:deleted_depot)

    result = Depot::DailyBalance.for_user(depot.user)

    depot.daily_balances.each do |daily_balance|
      assert_not_includes result, daily_balance
    end
  end

  def test_first_balance_starts_in_zero
    depot = depots(:fresh)
    balance = Depot::DailyBalance.create!(depot: depot,
                                          date: Time.zone.today,
                                          cached_depot_total_in_cents: 1500_00)

    assert_nil   balance.cached_depot_total_by_rate_in_cents
    assert_equal balance.cached_difference_in_cents, 0
    assert_equal balance.cached_difference_by_rate_in_cents, 0
    assert_equal balance.cached_difference_in_percentage, 0.00
    assert_equal balance.cached_difference_by_rate_in_percentage, 0.00
  end

  def test_depot_total_by_rate_in_cents
    assert_equal build_balance.cached_depot_total_by_rate_in_cents, (16_000_00 * (1/120.0)).to_i
  end

  def test_difference_in_cents
    assert_equal build_balance.cached_difference_in_cents, 1_000_00
  end

  def test_difference_in_percentage
    assert_equal build_balance.cached_difference_in_percentage, ((16_000_00 / 15_000_00.to_r) - 1) * 100
  end

  def test_difference_by_rate_in_cents
    yesterday_value_by_current_rate = 15_000_00 * (1/120.0)
    yesterday_value_by_previous_rate = 15_000_00 * (1/115.0)
    assert_equal build_balance.cached_difference_by_rate_in_cents, (yesterday_value_by_current_rate - yesterday_value_by_previous_rate).to_i
  end

  def test_difference_by_rate_in_percentage
    yesterday_by_rate_in_cents = (15_000_00 * (1/115.0)).to_i
    today_by_rate_in_cents     = (16_000_00 * (1/120.0)).to_i
    assert_equal build_balance.cached_difference_by_rate_in_percentage, ((today_by_rate_in_cents / yesterday_by_rate_in_cents.to_r) - 1) * 100
  end
end
