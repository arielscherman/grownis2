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
end
