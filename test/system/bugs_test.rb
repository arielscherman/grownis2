require "application_system_test_case"

class BugsTest < ApplicationSystemTestCase
  test "shows the page and highlight nav link" do
    sign_in users(:valid)

    visit bugs_url

    assert_selector "h1", text: "Tus Errores Reportados"
    assert_selector ".active[href='#{bugs_path}']"
  end

  test "displays all bugs from the given user (but not from others)" do
    bug                 = bugs(:bug)
    bug_from_other_user = bugs(:bug_from_other_user)
    user                = users(:valid)

    sign_in user

    visit bugs_url

    assert_selector    ".bug[data-id='#{bug.id}']"
    assert_no_selector ".bug[data-id='#{bug_from_other_user.id}']"
  end

  test "displays no bugs if user has none" do
    user = users(:valid_with_fresh_depot)
    sign_in user

    visit bugs_url

    assert_text "Aún no reportaste ningún error."
  end
end
