require "application_system_test_case"

class SuggestionsTest < ApplicationSystemTestCase
  test "shows the page and highlight nav link" do
    sign_in users(:valid)

    visit suggestions_url

    assert_selector "h1", text: "Tus Sugerencias"
    assert_selector ".active[href='#{suggestions_path}']"
  end

  test "displays all suggestions from the given user (but not from others)" do
    suggestion                 = suggestions(:suggestion)
    suggestion_from_other_user = suggestions(:suggestion_from_other_user)
    user                       = users(:valid)

    sign_in user

    visit suggestions_url

    assert_selector    ".suggestion[data-id='#{suggestion.id}']"
    assert_no_selector ".suggestion[data-id='#{suggestion_from_other_user.id}']"
  end

  test "displays no suggestions if user has none" do
    user = users(:valid_with_fresh_depot)
    sign_in user

    visit suggestions_url

    assert_text "Aún no hiciste ninguna sugerencia."
  end
end
