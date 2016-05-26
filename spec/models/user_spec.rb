require 'rails_helper'

describe User do
  it "returns all associated repos" do
    VCR.use_cassette('user#repos') do
      user  = User.new(ENV['TEST_TOKEN'])
      repos = user.repos
      repo  = repos.first

      expect(repos.count).to   eq(48)
      expect(repo.name).to     eq("swift")
      expect(repo.html_url).to eq("https://github.com/jdliss/swift")
    end
  end

  it "returns all associated events" do
    VCR.use_cassette('user#events') do
      user   = User.new(ENV['TEST_TOKEN'])
      events = user.events
      event  = events.first

      expect(events.count).to eq(30)
      expect(event.repo).to   eq("pindell-matt/api_curious")
    end
  end

  it "returns all activity for those user follows" do
    VCR.use_cassette('user#activity') do
      user     = User.new(ENV['TEST_TOKEN'])
      activity = user.activity_of_followed
      specific = activity.first

      expect(activity.count).to eq(30)
      expect(specific.type).to  eq("ForkEvent")
      expect(specific.id).to    eq("4062705267")
    end
  end

  it "returns total contributions in year" do
    VCR.use_cassette('user#contributions') do
      user          = User.new(ENV['TEST_TOKEN'])
      contributions = user.yearly_contributions.split(" ").first.to_i

      expect(contributions).to be > 800
    end
  end

  it "returns the starred repo count" do
    VCR.use_cassette('user#starred_repos') do
      user    = User.new(ENV['TEST_TOKEN'])
      starred = user.starred

      expect(starred).to eq(0)
    end
  end

  it "returns the users' followers count" do
    VCR.use_cassette('user#followers') do
      user      = User.new(ENV['TEST_TOKEN'])
      followers = user.followers

      expect(followers).to eq(20)
    end
  end

  it "returns the users' followed count" do
    VCR.use_cassette('user#following') do
      user     = User.new(ENV['TEST_TOKEN'])
      followed = user.following

      expect(followed).to eq(18)
    end
  end

  it "returns the users' name" do
    VCR.use_cassette('user#name') do
      user = User.new(ENV['TEST_TOKEN'])
      name = user.name

      expect(name).to eq("Matt Pindell")
    end
  end

  it "returns the users' login" do
    VCR.use_cassette('user#login') do
      user  = User.new(ENV['TEST_TOKEN'])
      login = user.login

      expect(login).to eq("pindell-matt")
    end
  end

end
