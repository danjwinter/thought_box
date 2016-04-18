require "rails_helper"

RSpec.feature "Authenticated user views links" do
  scenario "they can change an unread link to being read" do
    user = create(:user_with_links)
    link = user.links.last

    visit root_path

    fill_in "Email", with: "Gob@gmail.com"
    fill_in "Password", with: "password"
    click_on "Log in"

    within(".links") do
      expect(page).to have_content "Mark as Read"
      expect(page).to have_css ".unread-link"
      click_on "Mark as Read"
    end

    link.reload

    expect(link.read).to eq true

    within(".links") do
      expect(page).to have_content "Read: true"
      expect(page).to have_content "Mark as Unread"
      expect(page).to have_css ".read-link"
      click_on "Mark as Unread"
    end

    link.reload

    expect(link.read).to eq false

    within(".links") do
      expect(page).to have_content "Read: false"
    end
  end
end
