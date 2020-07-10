require 'test_helper'

class Depot::DailyBalance::DifferenceByRateCalculatorTest < ActiveSupport::TestCase
  def described_class; Depot::DailyBalance::DifferenceByRateCalculator; end

  test "#in_cents returns difference in cents between what the balance was and what it would have been today by the current rate" do
    previous_balance = Depot::DailyBalance.new(cached_depot_total_in_cents:         18_000_00,
                                               cached_depot_total_by_rate_in_cents: 163_63) # $110/ar

    # it only uses previous balance and rates
    # rate: equivalent to $120
    assert_equal described_class.new(previous_balance, nil, 0.0083333).in_cents, -13_63
  end

  test "#in_cents returns new balance if there is no previous balance" do
    balance = Depot::DailyBalance.new(cached_depot_total_in_cents: 20_000_00)

    assert_equal described_class.new(nil, balance, 0.0083333).in_cents, (20_000_00*0.0083333).to_i
  end

  test "#in_cents returns nil if there is no rate" do
    previous_balance = Depot::DailyBalance.new(cached_depot_total_in_cents: 20_000_00)
    balance          = Depot::DailyBalance.new(cached_depot_total_in_cents: 18_000_00)

    assert_nil described_class.new(previous_balance, balance, nil).in_cents
  end

  test "#in_percentage returns the ratio between those two balances" do
    balance1 = Depot::DailyBalance.new(cached_depot_total_by_rate_in_cents: 163_63)
    balance2 = Depot::DailyBalance.new(cached_depot_total_by_rate_in_cents: 150_00)

    assert_equal described_class.new(balance2, balance1, 0.0083333).in_percentage, 9.086666666666666
  end

  test "#in_percentage returns zero if there is no previous balance" do
    balance = Depot::DailyBalance.new(cached_depot_total_in_cents: 20_000_00)

    assert_equal described_class.new(nil, balance, 0.0083333).in_percentage, 0.0
  end

  test "#in_percentage returns nil if there is no rate" do
    balance1 = Depot::DailyBalance.new(cached_depot_total_by_rate_in_cents: 163_63)
    balance2 = Depot::DailyBalance.new(cached_depot_total_by_rate_in_cents: 150_00)

    assert_nil described_class.new(balance1, balance2, nil).in_percentage
  end
end
