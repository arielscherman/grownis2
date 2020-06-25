require "test_helper"

class Charts::DailyBalanceComponentTest < ViewComponent::TestCase
  test "render the data attributes for the js controller" do
    depot = depots(:national_bank)
    render_inline(Charts::DailyBalanceComponent.new(depot, depot.daily_balances))

    assert_selector(".daily-balance-chart[data-controller='charts--daily-balance']")
    assert_selector(".daily-balance-chart[data-charts--daily-balance-title-currency='Balance en ARS']")
    assert_selector(".daily-balance-chart[data-charts--daily-balance-title-rate='Equivalente en USD']")
  end

  test "render the data attributes for titles and categories" do
    depot = depots(:national_bank)
    render_inline(Charts::DailyBalanceComponent.new(depot, depot.daily_balances))
    dates = depot.daily_balances.map { |daily_balance| I18n.l(daily_balance.date, format: :short) }

    assert_selector(".daily-balance-chart[data-charts--daily-balance-title-currency='Balance en ARS']")
    assert_selector(".daily-balance-chart[data-charts--daily-balance-title-rate='Equivalente en USD']")
    assert_selector(".daily-balance-chart[data-charts--daily-balance-categories='#{dates.to_json}']")
  end

  test "renders the amounts data both in the main currency and its rate's" do
    depot = depots(:national_bank)
    daily_balances = depot.daily_balances
    result = render_inline(Charts::DailyBalanceComponent.new(depot, daily_balances))

    expected_data = [{
      name: "Balance en ARS",
      data: [amount_with_currency(daily_balances.first.cached_depot_total_in_cents, "ARS"),
             amount_with_currency(daily_balances.second.cached_depot_total_in_cents, "ARS"),
             amount_with_currency(daily_balances.last.cached_depot_total_in_cents, "ARS")]
    }, {
      name: "Equivalente en USD",
      data: [amount_with_currency(daily_balances.first.cached_depot_total_by_rate_in_cents, "USD"),
             amount_with_currency(daily_balances.second.cached_depot_total_by_rate_in_cents, "USD"),
             amount_with_currency(daily_balances.last.cached_depot_total_by_rate_in_cents, "USD")]
    }]

    assert_includes result.at_css(".daily-balance-chart").get_attribute("data-charts--daily-balance-series"), expected_data.to_json
  end
end
