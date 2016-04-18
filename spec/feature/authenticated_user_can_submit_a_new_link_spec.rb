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

      fill_in "Url", with: "http://www.arrested-development.com"
      fill_in "Title", with: "badassery"
      click_on "Create New Link"
    end

    expect(page).to have_content "http://www.arrested-development.com"
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

  scenario "they see only their own links" do
    user = create(:user)
    user_link = user.links.create(url: 'http://www.gob.com', title: 'I hope you know you AD')
    non_user_link = Link.create(url: 'http://www.google.com', title: 'google')

    visit root_path

    fill_in "Email", with: "Gob@gmail.com"
    fill_in "Password", with: "password"
    click_on "Log in"

    within('.links') do
      expect(page).to have_content user_link.title
      expect(page).to have_content user_link.url

      expect(page).to_not have_content non_user_link.title
      expect(page).to_not have_content non_user_link.url
    end
  end
end
