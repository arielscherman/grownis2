require "application_system_test_case"

class RatesTest < ApplicationSystemTestCase
  test "shows the page and highlight nav link" do
    sign_in users(:valid)

    visit rates_url

    assert_selector "h1", text: "Precios"
    assert_selector ".active[href='#{rates_path}']"
  end

  test "displays all rates" do
    user = users(:valid)

    sign_in user

    visit rates_url

    rates.each do |rate|
      if rate.latest_value
        assert_selector ".rate[data-id='#{rate.id}']", text: rate.name
        assert_selector ".rate[data-id='#{rate.id}']", text: raw_amount_with_currency(rate.latest_value.informative_value, rate.informative_currency.symbol)
      end
    end
  end
end
