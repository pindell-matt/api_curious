require 'rails_helper'

describe GithubService do
  it "returns data for a given user" do
    VCR.use_cassette('github_service#user') do
      service = GithubService.new(ENV["TEST_TOKEN"])
      user    = service.user_hash

      expect(user[:login]).to    eq("pindell-matt")
      expect(user[:id]).to       eq(8797393)
      expect(user[:html_url]).to eq("https://github.com/pindell-matt")
    end
  end
end
