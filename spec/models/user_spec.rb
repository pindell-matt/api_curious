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

  it "returns the starred repo count" do
    VCR.use_cassette('user#starred_repos') do
      user    = User.new(ENV['TEST_TOKEN'])
      starred = user.starred

      expect(starred).to eq(0)
    end
  end

  it "returns the users' followers count" do
    VCR.use_cassette('user#followers') do
      user    = User.new(ENV['TEST_TOKEN'])
      starred = user.followers

      expect(starred).to eq(20)
    end
  end

  it "returns the users' followed count" do
    VCR.use_cassette('user#following') do
      user    = User.new(ENV['TEST_TOKEN'])
      starred = user.following

      expect(starred).to eq(18)
    end
  end

  it "returns the users' name" do
    VCR.use_cassette('user#following') do
      user    = User.new(ENV['TEST_TOKEN'])
      starred = user.following

      expect(starred).to eq(18)
    end
  end

end
