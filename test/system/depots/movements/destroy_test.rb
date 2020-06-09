require "application_system_test_case"

class Depots::MovementsDestroyTest < ApplicationSystemTestCase
  test "deleting a movement causes the view to refresh" do
    movement = depot_movements(:deposit)

    sign_in users(:valid)

    visit depot_movements_url(depot_id: movement.depot_id)

    accept_alert do
      find(".movement[data-id='#{movement.id}'] .depot-movement-delete").click
    end

    assert_no_selector ".movement", text: amount_with_currency(movement.total_cents, movement.depot.currency_symbol)
  end

  test "deleting a movement causes the balance to update" do
    movement = depot_movements(:deposit)
    depot    = movement.depot

    depot.update!(cached_total_cents: movement.total_cents + 10000)
    initial_balance_in_cents = depot.cached_total_cents

    sign_in users(:valid)

    visit depot_movements_url(depot_id: movement.depot_id)

    accept_alert do
      find(".movement[data-id='#{movement.id}'] .depot-movement-delete").click
    end

    assert_selector ".balance", text: amount_with_currency(initial_balance_in_cents - movement.total_cents, depot.currency_symbol)
  end
end
