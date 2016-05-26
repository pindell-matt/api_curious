require 'rails_helper'

RSpec.feature "User can view their basic info" do
  scenario "only after logging in with Github" do
    VCR.use_cassette('feature#search') do
      token = ENV["TEST_TOKEN"]
      allow_any_instance_of(GithubOauthService).to receive(:get_access_token).and_return(token)

      visit root_path

      within(".navbar") do
        fill_in "Search CloneHub", with: "rust"
        click_button "Submit"
      end

      within(".flash-notice") do
        expect(page).to have_content("Please Login in order to Search!")
      end

      visit '/auth/github/callback'

      within(".navbar") do
        fill_in "Search CloneHub", with: "rust"
        click_button "Submit"
      end

      expect(page).to have_current_path('/search?q=rust')
      expect(page).to have_content("We’ve found 14110 repository results")

      within(".search-results") do
        expect(page).to have_content("rust rust-lang")
        expect(page).to have_content("A safe, concurrent, practical language.")
      end

    end
  end

end
