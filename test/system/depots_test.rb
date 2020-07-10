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

  test "displays all active depots for user" do
    user = users(:valid)
    sign_in user

    visit depots_url

    user.depots.active.find_each do |depot|
      assert_selector ".ui-card-title", text: depot.name.upcase
      assert_selector ".depot-balance", text: amount_with_currency(depot.cached_total_cents, depot.currency_symbol)
    end
  end

  test "does not display another user's depots" do
    user        = users(:valid)
    other_depot = users(:valid_with_one_depot).depots.first
    sign_in user

    visit depots_url

    assert_no_selector ".ui-card-title", text: other_depot.name.upcase
  end

  test "does not display soft deleted depots" do
    deleted_depot = depots(:deleted_depot)

    sign_in deleted_depot.user

    visit depots_url

    assert_no_selector ".ui-card-title", text: deleted_depot.name.upcase
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
