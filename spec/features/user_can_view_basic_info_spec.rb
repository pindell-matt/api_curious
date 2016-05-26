require 'rails_helper'

RSpec.feature "User can view their basic info" do
  scenario "after logging in with Github" do
    VCR.use_cassette('feature#basic') do
      token = ENV["TEST_TOKEN"]
      allow_any_instance_of(GithubOauthService).to receive(:get_access_token).and_return(token)

      visit '/auth/github/callback'

      save_and_open_page
    end
  end

end
