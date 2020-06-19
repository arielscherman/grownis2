require 'test_helper'

class Depot::DailyBalance::DifferenceCalculatorTest < ActiveSupport::TestCase
  def described_class; Depot::DailyBalance::DifferenceCalculator; end

  test "#in_cents returns difference in cents between two balances" do
    balance1 = Depot::DailyBalance.new(cached_depot_total_in_cents: 20_000_00)
    balance2 = Depot::DailyBalance.new(cached_depot_total_in_cents: 18_000_00)

    assert_equal described_class.new(balance2, balance1).in_cents, 2_000_00
  end

  test "#in_cents returns zero if there is no previous balance" do
    balance = Depot::DailyBalance.new(cached_depot_total_in_cents: 20_000_00)

    assert_equal described_class.new(nil, balance).in_cents, 0
  end

  test "#in_percentage returns the ratio between those two balances" do
    balance1 = Depot::DailyBalance.new(cached_depot_total_in_cents: 20_000_00)
    balance2 = Depot::DailyBalance.new(cached_depot_total_in_cents: 18_000_00)

    assert_equal described_class.new(balance2, balance1).in_percentage, 11.11111111111111
  end

  test "#in_percentage returns zero if there is no previous balance" do
    balance = Depot::DailyBalance.new(cached_depot_total_in_cents: 20_000_00)

    assert_equal described_class.new(nil, balance).in_percentage, 0.0
  end
end
