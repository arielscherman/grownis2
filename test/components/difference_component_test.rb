require "test_helper"

class DifferenceComponentTest < ViewComponent::TestCase
  test "renders the block given as green text when amount is positive" do
    render_inline(DifferenceComponent.new(100_00)) { "formatted amount" }

    assert_selector ".difference-component-value.text-green", text: "formatted amount"
  end

  test "renders the block given as red text when amount is negative" do
    render_inline(DifferenceComponent.new(-100_00)) { "formatted amount" }

    assert_selector ".difference-component-value.text-red", text: "formatted amount"
  end

  test "renders the arrow up if number is positive" do
    render_inline(DifferenceComponent.new(100_00)) { "foo" }

    assert_selector "i.icon-arrow-up"
  end

  test "renders the arrow down if number is negative" do
    render_inline(DifferenceComponent.new(-100_00)) { "foo" }

    assert_selector "i.icon-arrow-down"
  end

  test "renders the arrow down if number is zero" do
    render_inline(DifferenceComponent.new(0)) { "foo" }

    assert_selector "i.icon-arrow-up"
  end
end
