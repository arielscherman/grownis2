require "test_helper"

class Depot::CardComponentTest < ViewComponent::TestCase
  include Rails.application.routes.url_helpers

  test "renders links to depot actions" do
    depot = depots(:national_bank)
    render_inline(Depot::CardComponent.new(depot: depot))

    assert_selector "a[href='#{depot_path(depot)}']", text: "Ver"
    assert_selector "a[href='#{depot_movements_path(depot)}']", text: "Movimientos"
    assert_selector "a[href='#{edit_depot_path(depot)}']", text: "Editar"
  end

  test "renders depot's name in uppercase" do
    depot = depots(:national_bank)
    render_inline(Depot::CardComponent.new(depot: depot))

    assert_selector ".ui-card-title", text: depot.name.upcase
  end

  test "does not render differences if depot has no daily balance generated" do
    depot = depots(:fresh)
    render_inline(Depot::CardComponent.new(depot: depot))

    assert_no_selector ".difference-component"
  end

  test "does not render differences if depot has daily balance but is not rateable" do
    depot = depots(:american_bank)
    render_inline(Depot::CardComponent.new(depot: depot))

    assert_no_selector ".difference-component"
  end

  test "renders differences if depot has a rateable daily balance" do
    depot = depots(:national_bank)
    render_inline(Depot::CardComponent.new(depot: depot))

    assert_selector ".difference-component"
  end
end
