require "test_helper"

class Charts::RateComponentTest < ViewComponent::TestCase
  test "render the data attributes for the js controller" do
    rate = rates(:ars_in_dolar_blue)
    render_inline(Charts::RateComponent.new(rate, rate.values))

    assert_selector(".rate-values-chart[data-controller='charts--rate']")
  end

  test "render the data attributes for dates" do
    rate        = rates(:ars_in_dolar_blue)
    rate_values = rate.values
    render_inline(Charts::RateComponent.new(rate, rate_values))
    dates = rate_values.map { |rate_value| I18n.l(rate_value.date, format: :short) }

    assert_selector(".rate-values-chart[data-charts--rate-categories='#{dates.to_json}']")
  end

  test "renders the amounts data of rate's prices" do
    rate        = rates(:ars_in_dolar_blue)
    rate_values = rate.values
    result      = render_inline(Charts::RateComponent.new(rate, rate_values))

    prices = rate_values.map(&:informative_value)

    expected_data = [{ name: "En ARS", data: prices }]

    assert_includes result.at_css(".rate-values-chart").get_attribute("data-charts--rate-series"), expected_data.to_json
  end
end
