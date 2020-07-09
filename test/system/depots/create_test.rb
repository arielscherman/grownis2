require "application_system_test_case"

class DepotsCreateTest < ApplicationSystemTestCase
  test "creating a depot causes the view to refresh" do
    sign_in users(:valid)

    visit depots_url

    click_on "Agregar"
    fill_in "Nombre", with: "My new depot"

    page.find("#depot_currency_id + .choices__list").click
    page.find(".choices__item--choice[data-value='#{currencies(:usd).id}']").click

    click_on "Guardar"

    assert_selector ".depot", text: "MY NEW DEPOT"
    assert_selector ".depot-balance", text: amount_with_currency(0, "USD")
  end

  test "creating a depot removes the \"no depots\" message from the page" do
    sign_in users(:valid_without_depots)

    visit depots_url

    assert_selector ".no-depots"

    click_on "Agregar"
    fill_in "Nombre", with: "My new depot"

    page.find("#depot_currency_id + .choices__list").click
    page.find(".choices__item--choice[data-value='#{currencies(:usd).id}']").click

    click_on "Guardar"

    assert_no_selector ".no-depots"
  end

  test "allows selecting a rate when currency has at least one" do
    sign_in users(:valid)

    visit depots_url

    click_on "Agregar"
    fill_in "Nombre", with: "My new depot"

    page.find("#depot_currency_id + .choices__list").click
    page.find(".choices__item--choice[data-value='#{currencies(:ars).id}']").click

    page.find("#depot_rate_id + .choices__list").click
    page.find(".choices__item--choice[data-value='#{rates(:ars_in_dolar_mep).id}']").click

    click_on "Guardar"

    assert_selector ".depot", text: "MY NEW DEPOT"
    assert_selector ".depot-balance", text: amount_with_currency(0, "ARS")
  end

  test "shows an error when trying to save without picking a rate (when currency has rates)" do
    sign_in users(:valid)

    visit depots_url

    click_on "Agregar"
    fill_in "Nombre", with: "My new depot"

    page.find("#depot_currency_id + .choices__list").click
    page.find(".choices__item--choice[data-value='#{currencies(:ars).id}']").click

    click_on "Guardar"

    assert_selector ".ui-alert", text: "Valor de referencia no puede estar en blanco"
  end
end
