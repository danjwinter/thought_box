require "rails_helper"

RSpec.feature "User views links" do
  scenario "and can filter by read or unread" do
    i_need_javascript do
      user = create(:user_with_links)
      google = user.links.create(url: 'http://google.com', title: 'google', read: true)
      yahoo = user.links.create(url: 'http://yahoo.com', title: 'yahoo')

      visit root_path

      fill_in "Email", with: "Gob@gmail.com"
      fill_in "Password", with: "password"
      click_on "Log in"

      page.find('.filter-by-read').click

      expect(page).to have_selector("#link-#{google.id}", visible: true)
      expect(page).to have_selector("#link-#{yahoo.id}", visible: false)


      page.find('.filter-by-unread').click
      expect(page).to have_selector("#link-#{google.id}", visible: false)
      expect(page).to have_selector("#link-#{yahoo.id}", visible: true)

      page.find('.show-all').click
      expect(page).to have_selector("#link-#{google.id}", visible: false)
      expect(page).to have_selector("#link-#{yahoo.id}", visible: true)
    end
  end
end
