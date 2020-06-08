require "application_system_test_case"

class DepotsCreateTest < ApplicationSystemTestCase
  test "creating a depot causes the view to refresh" do
    sign_in users(:valid)

    visit depots_url

    click_on "Agregar"
    fill_in "Nombre", with: "My new depot"

    page.find("#depot_currency_id + .choices__list").click
    page.find(".choices__item--choice[data-value='#{currencies(:btc).id}']").click

    click_on "Guardar"

    assert_selector ".depot", text: "My new depot"
  end
end
