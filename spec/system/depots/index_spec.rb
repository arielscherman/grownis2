require "rails_helper"

RSpec.describe "Depots index", type: :system do
  it "displays the list of users depots" do
    user  = create(:user)
    depot = create(:depot)

    sign_in user

    visit depots_path

    expect(page).to have_content "Billeteras"
  end
end
