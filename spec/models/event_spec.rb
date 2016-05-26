require 'rails_helper'

describe Event do
  it "can return the assosciated repo's url" do
    data  = {
      type:        "PushEvent",
      repo:        { name: "pindell-matt/api_curious" },
      created_at:  "2016-04-26T03:42:57Z"
    }

    event = Event.new(data)

    expect(event.html_url).to eq("https://github.com/pindell-matt/api_curious")
  end

  it "can return the create time in relative words" do
    data  = {
      type:        "PushEvent",
      repo:        { name: "pindell-matt/api_curious" },
      created_at:  "2016-04-26T03:42:57Z"
    }
    event = Event.new(data)

    expect(event.create_time_in_words).to eq("about 1 month")
  end
end
