require 'rails_helper'

describe GithubService do
  it "returns user data for a given user" do
    VCR.use_cassette('github_service#user') do
      service = GithubService.new(ENV["TEST_TOKEN"])
      user    = service.user_hash

      expect(user[:avatar_url]).to eq("https://avatars.githubusercontent.com/u/8797393?v=3")
      expect(user[:name]).to       eq("Matt Pindell")
      expect(user[:login]).to      eq("pindell-matt")
      expect(user[:email]).to      eq("pindell.m@protonmail.com")
      expect(user[:created_at]).to eq("2014-09-16T19:59:39Z")
      expect(user[:followers]).to  eq(20)
      expect(user[:following]).to  eq(18)
      expect(user[:html_url]).to   eq("https://github.com/pindell-matt")
    end
  end

  it "returns the repos data for a given user" do
    VCR.use_cassette('github_service#repos') do
      service = GithubService.new(ENV["TEST_TOKEN"])
      repos   = service.repos_hash
      repo    = repos.first

      expect(repos.count).to      eq(48)
      expect(repo[:id]).to        eq(56370165)
      expect(repo[:name]).to      eq("swift")
      expect(repo[:full_name]).to eq("jdliss/swift")
    end
  end

  it "returns the starred repos data for a given user" do
    VCR.use_cassette('github_service#starred_repos') do
      service = GithubService.new(ENV["TEST_TOKEN"])
      repos   = service.starred_repos_hash

      expect(repos.count).to eq(0)
    end
  end
end
