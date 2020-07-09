require "application_system_test_case"

class MovementsCreateTest < ApplicationSystemTestCase
  test "creating a movement causes the view to refresh" do
    user  = users(:valid)
    depot = user.depots.first

    sign_in user

    visit movements_url

    click_on "Agregar Movimiento"

    page.find("#depot_movement_depot_id + .choices__list").click
    page.find(".choices__item--choice[data-value='#{depot.id}']").click

    fill_in "Total", with: "300.00"
    fill_in "Descripción", with: "Personal note"

    find("#depot_movement_date").click
    find(".flatpickr-day.today").click

    click_on "Guardar"

    movement = Depot::Movement.last
    assert_selector ".movement[data-id='#{movement.id}']", text: amount(300_00)
    assert_selector ".movement[data-id='#{movement.id}']", text: "Personal note"
    assert_selector ".movement[data-id='#{movement.id}']", text: depot.name
  end

  test "shows an empty page with no action if user has no depots" do
    user  = users(:valid_without_depots)

    sign_in user

    visit movements_url

    assert_no_selector "a[href='#{new_movement_path}']"
    assert_no_selector ".movement"
  end

  test "shows an error when trying to save without picking a depot" do
    user = users(:valid)

    sign_in user

    visit movements_url

    click_on "Agregar Movimiento"

    fill_in "Total", with: "300.00"
    fill_in "Descripción", with: "Personal note"

    find("#depot_movement_date").click
    find(".flatpickr-day.today").click

    click_on "Guardar"

    assert_selector ".ui-alert", text: "Billetera debe existir"
  end
end
