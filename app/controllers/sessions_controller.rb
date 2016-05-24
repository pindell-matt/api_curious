class SessionsController < ApplicationController

  def create
    redirect_to "https://github.com/login/oauth/authorize?client_id=#{ENV["GITHUB_CLIENT_ID"]}"
  end

  def callback
    @code = params['code']

    conn = Faraday.new(url: 'https://github.com') do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to STDOUT
      # faraday.response :json, :content_type => /\bjson$/
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end

    response = conn.post '/login/oauth/access_token', {
      client_id:     ENV["GITHUB_CLIENT_ID"],
      client_secret: ENV["GITHUB_CLIENT_SECRET"],
      code:          @code
    }

    # save access_token in session
    access_token = response.env['body'].split('&').first.split('=').last

    redirect_to "https://api.github.com/user?access_token=#{access_token}"

    # include it in the Authorization Header
  end

end
