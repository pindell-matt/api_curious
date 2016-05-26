require 'rails_helper'

describe Activity do
  it "can return the assosciated repo's url" do
    data  = {
      type:        "PushEvent",
      actor:       { login: "pindell-matt" },
      repo:        { name: "pindell-matt/api_curious" },
      created_at:  "2016-04-26T03:42:57Z"
    }

    activity = Activity.new(data)

    expect(activity.html_url).to eq("https://github.com/pindell-matt/api_curious")
  end

  it "can return the assosciated repo's name" do
    data  = {
      type:        "PushEvent",
      actor:       { login: "pindell-matt" },
      repo:        { name: "pindell-matt/api_curious" },
      created_at:  "2016-04-26T03:42:57Z"
    }

    activity = Activity.new(data)

    expect(activity.repo).to eq("pindell-matt/api_curious")
  end

  it "can return the actor who created the activity" do
    data  = {
      type:        "PushEvent",
      actor:       { login: "pindell-matt" },
      repo:        { name: "pindell-matt/api_curious" },
      created_at:  "2016-04-26T03:42:57Z"
    }

    activity = Activity.new(data)

    expect(activity.actor).to eq("pindell-matt")
  end

  it "can return the exact time in relative words" do
    data  = {
      type:        "PushEvent",
      actor:       { login: "pindell-matt" },
      repo:        { name: "pindell-matt/api_curious" },
      created_at:  "2016-04-26T03:42:57Z"
    }

    activity = Activity.new(data)

    expect(activity.update_time_in_words).to eq("about 1 month")
  end
end
