require "application_system_test_case"

class RatesShowTest < ApplicationSystemTestCase
  test "renders the rates chart" do
    rate = rates(:ars_in_dolar_blue)

    sign_in users(:valid)

    visit rate_url(rate)

    assert_selector ".rate-values-chart"
  end
end
