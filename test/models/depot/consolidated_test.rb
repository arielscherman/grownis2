require 'test_helper'

class Depot::ConsolidatedTest < ActiveSupport::TestCase
  def described_class; Depot::Consolidated; end

  test "starts with totals in zero" do
    consolidated = described_class.new

    assert_equal consolidated.in_cents, 0
    assert_equal consolidated.difference_in_cents, 0
  end

  test "adds the value in USD when depot's currency is not" do
    consolidated = described_class.new
    depot        = depots(:national_bank)

    consolidated.add(depot)

    assert_equal consolidated.in_cents, depot.latest_daily_balance.cached_depot_total_by_rate_in_cents
    assert_equal consolidated.difference_in_cents, depot.latest_daily_balance.cached_difference_by_rate_in_cents
  end

  test "adds the value in USD when depot's currency is USD" do
    consolidated = described_class.new
    depot        = depots(:american_bank)

    consolidated.add(depot)

    assert_equal consolidated.in_cents, depot.latest_daily_balance.cached_depot_total_in_cents
    assert_equal consolidated.difference_in_cents, depot.latest_daily_balance.cached_difference_in_cents
  end

  test "can add depots with different currencies using the rated values" do
    consolidated           = described_class.new
    depot_in_ars           = depots(:national_bank)
    depot_in_usd           = depots(:american_bank)
    depot_without_balance  = depots(:fresh)

    consolidated.add(depot_in_ars)
    consolidated.add(depot_in_usd)
    consolidated.add(depot_without_balance) # doesn't add it

    expected_total_cents      = depot_in_ars.latest_daily_balance.cached_depot_total_by_rate_in_cents + \
                                depot_in_usd.latest_daily_balance.cached_depot_total_in_cents
    expected_total_difference = depot_in_ars.latest_daily_balance.cached_difference_by_rate_in_cents + \
                                depot_in_usd.latest_daily_balance.cached_difference_in_cents

    assert_equal consolidated.in_cents, expected_total_cents
    assert_equal consolidated.difference_in_cents, expected_total_difference
  end

  test "total stays at zero if only adding a depot without balance" do
    consolidated           = described_class.new
    depot_without_balance  = depots(:fresh)

    consolidated.add(depot_without_balance)

    assert_equal consolidated.in_cents, 0
    assert_equal consolidated.difference_in_cents, 0
  end
end
