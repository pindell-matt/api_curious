class SessionsController < ApplicationController

  def create
    redirect_to "https://github.com/login/oauth/authorize?client_id=#{ENV["GITHUB_CLIENT_ID"]}"
  end

  def callback
    @code = params['code']

    connection = Faraday.new(url: 'https://github.com') do |faraday|
      faraday.request  :url_encoded
      faraday.response :logger
      # faraday.response :json, :content_type => /\bjson$/
      faraday.adapter  Faraday.default_adapter
    end

    response = connection.post '/login/oauth/access_token', {
      client_id:     ENV["GITHUB_CLIENT_ID"],
      client_secret: ENV["GITHUB_CLIENT_SECRET"],
      code:          @code
    }

    # save access_token in session
    # must be a better way of getting this
    access_token = response.env['body'].split('&').first.split('=').last
    # include it in the Authorization Header
    session[:token] = access_token


    conn = Faraday.new(url: 'https://api.github.com') do |faraday|
      faraday.request  :url_encoded
      faraday.response :logger
      faraday.adapter  Faraday.default_adapter
    end

    example = conn.get '/user', { access_token: "#{access_token}" }
    json_ex = JSON.parse(example.body)

    repos     = conn.get '/user/repos', { access_token: "#{access_token}" }
    json_repo = JSON.parse(repos.body)

    # require "pry"
    # binding.pry

    redirect_to "https://api.github.com/user?access_token=#{access_token}"
  end

end
