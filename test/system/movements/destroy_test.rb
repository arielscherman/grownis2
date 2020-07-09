require "application_system_test_case"

class MovementsDestroyTest < ApplicationSystemTestCase
  test "deleting a movement causes the view to refresh" do
    movement = depot_movements(:deposit)

    sign_in users(:valid)

    visit movements_url

    assert_selector ".movement", text: amount_with_currency(movement.total_cents, movement.depot.currency_symbol)

    accept_alert do
      find(".movement[data-id='#{movement.id}'] .depot-movement-delete").click
    end

    assert_no_selector ".movement", text: amount_with_currency(movement.total_cents, movement.depot.currency_symbol)
  end
end
