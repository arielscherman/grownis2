require "application_system_test_case"

class DepotsCreateTest < ApplicationSystemTestCase
  test "creating a depot causes the view to refresh" do
    sign_in users(:valid)

    visit depots_url

    click_on "Agregar"
    fill_in "Nombre", with: "My new depot"
    select currencies(:btc).name, from: "Moneda"

    within ".modal-content" do
      click_on "Guardar"
    end

    assert_selector ".depot", text: "My new depot"
  end
end
