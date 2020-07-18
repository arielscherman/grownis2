require "application_system_test_case"

class DepotsShowTest < ApplicationSystemTestCase
  test "displays rate equivalent and price if wallet has a rated daily balance" do
    depot = depots(:national_bank)

    sign_in users(:valid)

    visit depot_url(depot)

    assert_selector ".depot-card-balance", text: amount_with_currency(depot.cached_total_cents, "ARS")
    assert_selector ".depot-card-rated-balance", text: amount_with_currency(depot.latest_daily_balance.cached_depot_total_by_rate_in_cents, "USD")
    assert_selector ".rate-card-value", text: raw_amount_with_currency((1 / depot.latest_daily_balance.cached_rate_value).round(2), "ARS")
    assert_selector ".daily-balance-chart"
  end

  test "displays rate equivalent and price if wallet has a rated daily balance but is measured in the end currency" do
    depot = depots(:ledger_btc)

    sign_in users(:valid)

    visit depot_url(depot)

    assert_selector ".depot-card-balance", text: amount_with_currency(depot.cached_total_cents, "BTC")
    assert_selector ".depot-card-rated-balance", text: amount_with_currency(depot.latest_daily_balance.cached_depot_total_by_rate_in_cents, "USD")
    assert_selector ".rate-card-value", text: raw_amount_with_currency(depot.latest_daily_balance.cached_rate_value.round(2), "USD")
    assert_selector ".daily-balance-chart"
  end

  test "does not display depot's equivalent in rate and rate price for depots in USD" do
    depot = depots(:american_bank)

    sign_in users(:valid)

    visit depot_url(depot)

    assert_selector ".depot-card-balance", text: amount_with_currency(depot.cached_total_cents, "USD")
    assert_selector ".daily-balance-chart"
    assert_no_selector ".depot-card-rated-balance"
    assert_no_selector ".rate-card-value"
  end
end
