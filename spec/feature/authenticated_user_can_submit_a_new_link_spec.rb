require "rails_helper"

RSpec.feature "Authenticated user visits main page", type: :feature do
  scenario "they can create a new link" do
    user = create(:user)

    visit root_path

    fill_in "Email", with: "Gob@gmail.com"
    fill_in "Password", with: "password"
    click_on "Log in"

    within(".new-link") do
      expect(page).to have_content "Create New Link"
      expect(page).to have_content "Title"
      expect(page).to have_content "Url"

      fill_in "Url", with: "www.arrested-development.com"
      fill_in "Title", with: "badassery"
      click_on "Create New Link"
    end

    expect(page).to have_content "www.arrested-development.com"
    expect(page).to have_content "badassery"
    expect(page).to have_content "Read: false"

    visit root_path

    within(".links") do
      expect(page).to have_content "www.arrested-development.com"
      expect(page).to have_content "badassery"
      expect(page).to have_content "Read: false"
    end
  end

  scenario "the link must be valid with http in front" do
    user = create(:user)

    visit root_path

    fill_in "Email", with: "Gob@gmail.com"
    fill_in "Password", with: "password"
    click_on "Log in"

    within(".new-link") do
      expect(page).to have_content "Create New Link"
      expect(page).to have_content "Title"
      expect(page).to have_content "Url"

      fill_in "Url", with: "arrested-development"
      fill_in "Title", with: "badassery"
      click_on "Create New Link"
    end

    expect(current_path).to eq links_path

    within(".new-link") do
      expect(page).to have_content "Url is not valid"
    end
  end
end
