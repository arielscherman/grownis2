require "application_system_test_case"

class DepotsTest < ApplicationSystemTestCase
  test "visiting the index" do
    sign_in users(:valid)

    visit depots_url

    assert_selector "h1", text: "Billeteras"
  end

  test "shows an empty collection for a fresh users" do
    sign_in users(:valid_without_depots)

    visit depots_url

    assert_selector "h1", text: "Billeteras"
  end

  test "displays all depots for user" do
    user = users(:valid)
    sign_in user

    visit depots_url

    user.depots.find_each do |depot|
      assert_selector ".ui-card-title", text: depot.name.upcase
      assert_selector ".depot-balance", text: amount_with_currency(depot.cached_total_cents, depot.currency_symbol)
    end
  end

  test "displays the empty depot for user that has only one fresh" do
    user = users(:valid_with_fresh_depot)
    depot = user.depots.first
    sign_in user

    visit depots_url

    assert_selector ".ui-card-title", text: depot.name.upcase
    assert_selector ".depot-balance", text: amount_with_currency(depot.cached_total_cents, depot.currency_symbol)
  end
end
