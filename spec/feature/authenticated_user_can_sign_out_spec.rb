require "rails_helper"

RSpec.feature "Authenticated user can sign out", type: :feature do
  scenario "when they visit the root as Authenticated user, they can sign out" do
    user = create(:user)

    visit root_path

    fill_in "Email", with: "Gob@gmail.com"
    fill_in "Password", with: "password"
    click_on "Log in"

    expect(page).to have_content "Sign Out"

    click_on "Sign Out"

    expect(current_path).to eq login_path
  end
end
