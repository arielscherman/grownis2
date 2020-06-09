require "application_system_test_case"

class Depots::MovementsDestroyTest < ApplicationSystemTestCase
  test "deleting a movement causes the view to refresh" do
    movement = depot_movements(:deposit)

    sign_in users(:valid)

    visit depot_movements_url(depot_id: movement.depot_id)

    accept_alert do
      find(".movement[data-id='#{movement.id}'] .depot-movement-delete").click
    end

    assert_no_selector ".movement", text: movement.total
  end
end
