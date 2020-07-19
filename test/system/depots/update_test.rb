require "application_system_test_case"

class DepotsUpdateTest < ApplicationSystemTestCase
  test "updating a depot causes the view to refresh" do
    depot = depots(:national_bank)

    sign_in depot.user

    visit depots_url

    find("a[href='#{edit_depot_path(depot)}']").click

    fill_in "Nombre", with: "My cool depot"

    click_on "Guardar"

    assert_selector ".depot", text: "MY COOL DEPOT"
  end

  test "changing the currency on an existing depot is not allowed" do
    depot = depots(:national_bank)

    sign_in depot.user

    visit depots_url

    find("a[href='#{edit_depot_path(depot)}']").click

    assert_css "#depot_currency_id[disabled]", visible: false
  end

  test "only displays rates for the depot's selected currency" do
    depot = depots(:national_bank)

    sign_in users(:valid)

    visit depots_url

    find("a[href='#{edit_depot_path(depot)}']").click
    find("#depot_rate_id + .choices__list").click

    assert_selector    ".choices__item--choice[data-value='#{rates(:ars_in_dolar_mep).id}']"
    assert_no_selector ".choices__item--choice[data-value='#{rates(:btc_in_usd).id}']"
  end
end
