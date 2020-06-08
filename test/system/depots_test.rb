require "application_system_test_case"

class DepotsTest < ApplicationSystemTestCase
  test "visiting the index" do
    sign_in users(:valid)

    visit depots_url

    assert_selector "h1", text: "Billeteras"
  end
end
