require "test_helper"

class Charts::Users::ConsolidatedBalanceComponentTest < ViewComponent::TestCase
  test "render the data attributes for the js controller" do
    depot = depots(:american_bank)
    render_inline(Charts::Users::ConsolidatedBalanceComponent.new(depot.daily_balances))

    assert_selector(".user-consolidated-balance-chart[data-controller='charts--users--consolidated-balance']")
  end

  test "render the data attributes for titles and categories" do
    depot = depots(:american_bank)
    render_inline(Charts::Users::ConsolidatedBalanceComponent.new(depot.daily_balances))
    dates = depot.daily_balances.map { |daily_balance| I18n.l(daily_balance.date, format: :short) }.sort

    assert_selector(".user-consolidated-balance-chart[data-charts--users--consolidated-balance-categories='#{dates.to_json}']")
  end

  test "renders the amounts data in the main currency when it is usd" do
    depot = depots(:american_bank)
    daily_balances = depot.daily_balances.order(:date)
    result = render_inline(Charts::Users::ConsolidatedBalanceComponent.new(daily_balances))

    expected_data = [{
      name: "Total en USD",
      data: [amount_with_currency(daily_balances.first.cached_depot_total_in_cents, "USD"),
             amount_with_currency(daily_balances.second.cached_depot_total_in_cents, "USD")]
    }]

    assert_includes result.at_css(".user-consolidated-balance-chart").get_attribute("data-charts--users--consolidated-balance-series"), expected_data.to_json
  end

  test "renders the amounts data in usd even if depot's currency is not" do
    depot = depots(:national_bank)
    daily_balances = depot.daily_balances.order(:date)
    result = render_inline(Charts::Users::ConsolidatedBalanceComponent.new(daily_balances))

    expected_data = [{
      name: "Total en USD",
      data: [amount_with_currency(daily_balances.first.cached_depot_total_by_rate_in_cents, "USD"),
             amount_with_currency(daily_balances.second.cached_depot_total_by_rate_in_cents, "USD"),
             amount_with_currency(daily_balances.last.cached_depot_total_by_rate_in_cents, "USD")]
    }]

    assert_includes result.at_css(".user-consolidated-balance-chart").get_attribute("data-charts--users--consolidated-balance-series"), expected_data.to_json
  end

  test "renders an empty collection if depot has no balances" do
    depot = depots(:fresh)
    result = render_inline(Charts::Users::ConsolidatedBalanceComponent.new(depot.daily_balances))

    assert_includes result.at_css(".user-consolidated-balance-chart").get_attribute("data-charts--users--consolidated-balance-series"), [{ name: "Total en USD", data: [] }].to_json
  end
end
