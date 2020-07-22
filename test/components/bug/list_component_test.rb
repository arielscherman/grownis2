require "test_helper"

class Bug::ListComponentTest < ViewComponent::TestCase
  test "renders en empty message when no bugs found" do
    render_inline(Bug::ListComponent.new(bugs: []))

    assert_no_selector ".bug"
    assert_text        "Aún no reportaste ningún error"
  end

  test "renders all bugs given" do
    bug = bugs(:bug)

    render_inline(Bug::ListComponent.new(bugs: [bug]))

    assert_selector ".bug[data-id='#{bug.id}']", text: I18n.l(bug.created_at)
    assert_selector ".bug[data-id='#{bug.id}']", text: bug.title
    assert_selector ".bug[data-id='#{bug.id}']", text: bug.description
  end
end
