require 'rails_helper'

describe User do
  it "returns all associated repos" do
    VCR.use_cassette('user#repos', record: :new_episodes) do
      user  = User.new(ENV['TEST_TOKEN'])
      repos = user.repos
      repo  = repos.first

      expect(repos.count).to   eq(48)
      expect(repo.name).to     eq("swift")
      expect(repo.html_url).to eq("https://github.com/jdliss/swift")
    end
  end
end
