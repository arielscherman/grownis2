require "application_system_test_case"

class MovementsTest < ApplicationSystemTestCase
  test "visiting the index" do
    sign_in users(:valid)

    visit movements_url

    assert_selector "h1", text: "Movimientos"
  end

  test "displays all movements from multiple depots" do
    user = users(:valid)
    user_movements = [
      depot_movements(:deposit),
      depot_movements(:usd_deposit)
    ]

    sign_in user

    visit movements_url

    user_movements.each do |movement|
      assert_selector ".movement[data-id='#{movement.id}']", text: amount_with_currency(movement.total_cents, movement.depot.currency_symbol)
    end
  end

  test "does not display movements from other user's depots" do
    user = users(:valid)
    other_user_movement = users(:valid_with_one_depot).depots.first.movements.first

    sign_in user

    visit movements_url

    assert_no_selector ".movement[data-id='#{other_user_movement.id}']"
  end

  test "does not display movements from deleted depots" do
    movement = depot_movements(:deposit_in_deleted_depot)

    sign_in movement.depot.user

    visit movements_url

    assert_no_selector ".movement[data-id='#{movement.id}']"
  end

  test "displays the empty depot for user that has only one fresh" do
    user = users(:valid_with_fresh_depot)
    sign_in user

    visit movements_url

    assert_text "Aún no tenés ningún movimiento"
  end
end
