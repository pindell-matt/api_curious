require 'rails_helper'

describe GithubService do
  it "returns all repos for given User" do
    VCR.use_cassette('github_service#user') do
      service = GithubService.new
      repos   = service.repos
      repo    = repos.first

      expect(legislators.count).to       eq(20)
      expect(legislator[:first_name]).to eq("Joni")
      expect(legislator[:last_name]).to  eq("Ernst")
    end
  end
end
