require "rails_helper"

RSpec.feature "Guest can log in", type: :feature do
  scenario "when they visit the root path, they are prompted to log in" do
    visit root_path

    expect(page).to have_content "Log In or Sign Up"
  end
end
