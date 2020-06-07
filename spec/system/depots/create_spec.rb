require "rails_helper"

RSpec.feature "Depot creation", type: :system do
  it "allows to create a depot", js: true do
    currency = create(:currency, :usd)

    sign_in create(:user)
    binding.pry

    visit depots_url

    click_on "Agregar"

    fill_in "Nombre", with: "My new depot"
    select currency.name, from: "Moneda"

    within ".modal-content" do
      click_on "Guardar"
    end

    expect(page).to have_css ".depot", text: "My new depot"
  end
end
