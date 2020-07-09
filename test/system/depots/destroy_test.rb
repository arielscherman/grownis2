require "application_system_test_case"

class DepotsDestroyTest < ApplicationSystemTestCase
  test "deleting a depots removes it from the UI" do
    depot = depots(:national_bank)

    sign_in users(:valid)

    visit depots_url

    assert_selector ".depot[data-id='#{depot.id}']"

    accept_alert do
      find(".depot[data-id='#{depot.id}'] .depot-delete").click
    end

    assert_no_selector ".depot[data-id='#{depot.id}']"
  end
end
