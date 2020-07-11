require "test_helper"

class Charts::DailyBalanceComponentTest < ViewComponent::TestCase
  test "render the data attributes for the js controller" do
    depot = depots(:american_bank)
    render_inline(Charts::DailyBalanceComponent.new(depot, depot.daily_balances))

    assert_selector(".daily-balance-chart[data-controller='charts--daily-balance']")
    assert_selector(".daily-balance-chart[data-charts--daily-balance-title-currency='Balance en USD']")
  end

  test "render the data attributes for titles and categories" do
    depot = depots(:american_bank)
    render_inline(Charts::DailyBalanceComponent.new(depot, depot.daily_balances))
    dates = depot.daily_balances.map { |daily_balance| I18n.l(daily_balance.date, format: :short) }

    assert_selector(".daily-balance-chart[data-charts--daily-balance-title-currency='Balance en USD']")
    assert_selector(".daily-balance-chart[data-charts--daily-balance-categories='#{dates.to_json}']")
  end

  test "renders the amounts data both in the main currency and its rate's" do
    depot = depots(:american_bank)
    daily_balances = depot.daily_balances.order(:date)
    result = render_inline(Charts::DailyBalanceComponent.new(depot, daily_balances))

    expected_data = [{
      name: "Balance en USD",
      data: [amount_for_chart(daily_balances.first.cached_depot_total_in_cents),
             amount_for_chart(daily_balances.second.cached_depot_total_in_cents)]
    }]

    assert_includes result.at_css(".daily-balance-chart").get_attribute("data-charts--daily-balance-series"), expected_data.to_json
  end
end
