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

  it "returns the organizations for a given user" do
    VCR.use_cassette('github_service#organizations') do
      service       = GithubService.new(ENV["TEST_TOKEN"])
      organizations = service.organizations_hash
      organization  = organizations.first

      expect(organizations.count).to  eq(1)
      expect(organization[:login]).to eq("apiiiiii")
      expect(organization[:id]).to    eq(19580612)
      expect(organization[:url]).to   eq("https://api.github.com/orgs/apiiiiii")
    end
  end

  it "returns the recent events associated with a given user" do
    VCR.use_cassette('github_service#recent_events') do
      service       = GithubService.new(ENV["TEST_TOKEN"])
      recent_events = service.recent_events_hash

      expect(recent_events.count).to eq(30)
    end
  end

  it "returns the recent activity associated with accounts a user follows" do
    VCR.use_cassette('github_service#followed_activity') do
      service           = GithubService.new(ENV["TEST_TOKEN"])
      followed_activity = service.recent_events_hash

      expect(followed_activity.count).to eq(30)
    end
  end

  it "returns the total yearly contributions for a user" do
    VCR.use_cassette('github_service#contributions_in_year') do
      service               = GithubService.new(ENV["TEST_TOKEN"])
      contributions_in_year = service.get_yearly_contributions.split(" ").first.to_i

      expect(contributions_in_year).to be > 800
    end
  end
end
