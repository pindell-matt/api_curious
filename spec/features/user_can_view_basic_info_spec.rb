require 'rails_helper'

RSpec.feature "User can view their basic info" do
  scenario "after logging in with Github" do
    VCR.use_cassette('feature#basic') do
      token = ENV["TEST_TOKEN"]
      allow_any_instance_of(GithubOauthService).to receive(:get_access_token).and_return(token)

      visit '/auth/github/callback'

      within(".basic-user-info") do
        expect(page).to have_content("Matt Pindell")
        expect(page).to have_content("pindell-matt")
        expect(page).to have_content("pindell.m@protonmail.com")
        expect(page).to have_content("Joined on 2014-09-16T19:59:39Z")
      end

      within(".vcard-stats") do
        expect(page).to have_content("20 Followers")
        expect(page).to have_content("0 Starred")
        expect(page).to have_content("18 Following")
      end

    end
  end

end
