require "rails_helper"

RSpec.feature "User views links" do
  scenario "and can update read status without leaving page" do
    i_need_javascript do
      user = create(:user_with_links)
      google = user.links.create(url: 'http://google.com', title: 'google')
      yahoo = user.links.create(url: 'http://yahoo.com', title: 'yahoo')

      visit root_path

      fill_in "Email", with: "Gob@gmail.com"
      fill_in "Password", with: "password"
      click_on "Log in"

      within(".search-box") do
        fill_in "Search", with: 'g'
      end
      expect(page).to have_selector("#link-#{google.id}", visible: true)
      expect(page).to have_selector("#link-#{yahoo.id}", visible: false)
    end
  end
end
