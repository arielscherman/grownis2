require "application_system_test_case"

class Depots::MovementsCreateTest < ApplicationSystemTestCase
  test "creating a movement causes the view to refresh" do
    sign_in users(:valid)

    visit depot_movements_url(depot_id: depots(:national_bank))

    click_on "Agregar Movimiento"

    fill_in "Total", with: "300.00"

    find("#depot_movement_date").click
    find(".flatpickr-day.today").click

    click_on "Guardar"

    assert_selector ".movement", text: "300"
  end
end
