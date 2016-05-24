class HomeController < ApplicationController

  def show
    # place in application controller?
    conn = Faraday.new(url: 'https://api.github.com') do |faraday|
      faraday.request  :url_encoded
      faraday.response :logger
      faraday.adapter  Faraday.default_adapter
    end

    user       = conn.get '/user', { access_token: "#{session[:token]}" }
    json_user  = JSON.parse(user.body)
    @user_name = json_user["login"]
    @user_id   = json_user["id"]
    @avatar    = json_user["avatar_url"]

    # require "pry"
    # binding.pry
  end
end
