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
end
