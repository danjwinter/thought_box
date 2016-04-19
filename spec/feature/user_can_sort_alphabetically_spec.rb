RSpec.feature "User views links" do
  scenario "and can sort alphabetically" do
    i_need_javascript do
      user = create(:user)
      yahoo = user.links.create(url: 'http://yahoo.com', title: 'yahoo')
      google = user.links.create(url: 'http://google.com', title: 'google')

      visit root_path

      fill_in "Email", with: "Gob@gmail.com"
      fill_in "Password", with: "password"
      click_on "Log in"

      elements = all('.link')
      expect(elements[0]).to have_content 'yahoo'

      page.find('.sort-alphabetically').click

      expect(elements[0]).to have_content 'yahoo'
    end
  end
end
