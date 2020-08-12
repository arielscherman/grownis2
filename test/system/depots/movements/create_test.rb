require "application_system_test_case"

class Depots::MovementsCreateTest < ApplicationSystemTestCase
  test "creating a movement causes the view to refresh" do
    sign_in users(:valid)

    visit depot_movements_url(depot_id: depots(:national_bank))

    click_on "Agregar Movimiento"

    fill_in "Total", with: "300.00"
    fill_in "Descripción", with: "Personal note"

    click_on "Guardar"

    assert_selector ".movement", text: amount(300_00)
    assert_selector ".movement", text: "Personal note"
  end

  test "creating the first movement removes the empty message" do
    user = users(:valid_with_fresh_depot)
    depot = user.depots.first

    sign_in user

    visit depot_movements_url(depot_id: depot.id)

    assert_selector ".no-movements"

    click_on "Agregar Movimiento"

    fill_in "Total", with: "300.00"
    fill_in "Descripción", with: "Personal note"

    click_on "Guardar"

    assert_no_selector ".no-movements"
    assert_selector ".movement", text: amount(300_00)
    assert_selector ".movement", text: "Personal note"
  end

  test "creating a movement causes the balance to update" do
    depot = depots(:national_bank)

    sign_in users(:valid)

    visit depot_movements_url(depot_id: depot)

    click_on "Agregar Movimiento"

    fill_in "Total", with: "300.00"

    click_on "Guardar"

    assert_selector ".depot-balance", text: amount(300_00)
  end
end
