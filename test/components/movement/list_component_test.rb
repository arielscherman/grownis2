require "test_helper"

class Movement::ListComponentTest < ViewComponent::TestCase
  include Rails.application.routes.url_helpers

  test "renders en empty message when no movements found" do
    render_inline(Movement::ListComponent.new(movements: []))

    assert_no_selector ".movement"
    assert_text        "Aún no tenés ningún movimiento"
  end

  test "renders all movements given" do
    collection = [
      depot_movements(:deposit),
      depot_movements(:old_deposit),
      depot_movements(:withdrawal)
    ]

    render_inline(Movement::ListComponent.new(movements: collection))

    collection.each do |movement|
      assert_selector ".movement[data-id='#{movement.id}']", text: I18n.l(movement.date)
      assert_selector ".movement[data-id='#{movement.id}']", text: movement.description
      assert_selector ".movement[data-id='#{movement.id}'] .difference-component" # component renders
    end
  end

  test "renders link to wallets if show_depot option is true" do
    collection = [
      depot_movements(:deposit),
      depot_movements(:usd_deposit),
    ]

    render_inline(Movement::ListComponent.new(movements: collection, show_depot: true))

    collection.each do |movement|
      assert_selector ".movement[data-id='#{movement.id}'].with-depot"
      assert_selector "a[href='#{depot_path(movement.depot)}']", text: movement.depot.name
    end
  end

  test "does not render link to wallets if show_depot option is not given" do
    collection = [
      depot_movements(:deposit),
      depot_movements(:usd_deposit),
    ]

    render_inline(Movement::ListComponent.new(movements: collection))

    collection.each do |movement|
      assert_no_selector "a[href='#{depot_path(movement.depot)}']", text: movement.depot.name
    end
  end
end
