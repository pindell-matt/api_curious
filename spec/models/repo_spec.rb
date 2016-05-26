require 'rails_helper'

describe Repo do
  it "can return the relative updated_at time" do
    data  = {
      name:        "swift",
      owner:       { login: "jdliss" },
      html_url:    "https://github.com/jdliss/swift",
      description: "get shwifty",
      updated_at:  "2016-04-23T03:34:16Z"
    }

    repo = Repo.new(data)

    expect(repo.update_time_in_words).to eq("about 1 month")
  end
end
