require "rails_helper"

RSpec.feature "Authenticated user views links" do
  scenario "and they can edit that link" do
    user = create(:user_with_links)
    link = user.links.last

    visit root_path

    fill_in "Email", with: "Gob@gmail.com"
    fill_in "Password", with: "password"
    click_on "Log in"

    within(".links") do
      expect(page).to have_content "Edit"
      click_on "Edit"
    end

    expect(current_path).to eq edit_link_path(link)
    expect(page).to have_content "Title"
    expect(page).to have_content "Url"

    fill_in "Url", with: "http://spasmic-platypus.com"
    fill_in "Title", with: "Yeah, I'm getting loopy alright"
    click_on "Update Link"

    link.reload

    expect(current_path).to eq links_path

    within('.links') do
      expect(page).to have_content "http://spasmic-platypus.com"
      expect(page).to have_content "Yeah, I'm getting loopy alright"
    end
  end
end
