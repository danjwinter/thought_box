require "rails_helper"

RSpec.feature "Signed up user can log in", type: :feature do
  scenario "when they visit the root path and are not signed in, they can log in" do
    create(:user)
    visit root_path

    fill_in "Username", with: "Gob"
    fill_in "Password", with: "password"
    click_on "Log in"

    expect(current_path).to eq links_path
  end
end
