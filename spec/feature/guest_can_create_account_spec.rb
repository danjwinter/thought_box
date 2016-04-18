require "rails_helper"

RSpec.feature "Guest can log in or sign up", type: :feature do
  scenario "when they visit the root path, they are prompted to log in" do
    visit root_path

    expect(page).to have_content "Log In or Sign Up"
    expect(current_path).to eq login_path
  end

  scenario "they can create a new account" do
    visit root_path

    click_on "Sign up"

    expect(current_path).to eq sign_up_path
    expect(page).to have_content "Email"
    expect(page).to have_content "Password"

    fill_in "Email", with: "Gob"
    fill_in "Password", with: "pass"
    fill_in "Password confirmation", with: "pass"
    click_on "Create Account"

    expect(current_path).to eq links_path
  end
end
