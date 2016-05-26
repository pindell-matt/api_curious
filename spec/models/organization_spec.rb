require 'rails_helper'

describe Organization do
  it "can return the assosciated organization's url" do
    data  = {
      login:      "fake_organization",
      avatar_url: "https://avatars.githubusercontent.com/u/8797393?v=3"
    }

    organization = Organization.new(data)

    expect(organization.html_url).to eq("https://github.com/fake_organization")
  end
end
