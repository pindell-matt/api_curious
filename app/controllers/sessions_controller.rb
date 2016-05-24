class SessionsController < ApplicationController

  def create
    redirect_to "https://github.com/login/oauth/authorize?client_id=#{ENV["GITHUB_CLIENT_ID"]}"
  end

  def callback
    code = params['code']

    connection = Faraday.new(url: 'https://github.com')

    response = connection.post '/login/oauth/access_token', {
      client_id:     ENV["GITHUB_CLIENT_ID"],
      client_secret: ENV["GITHUB_CLIENT_SECRET"],
      code:          code
    }

    # must be a better way of getting this with JSON.parse / different faraday post?
    access_token = response.env['body'].split('&').first.split('=').last
    session[:token] = access_token

    redirect_to root_path
  end

  def destroy
    session.clear
    redirect_to root_path
  end

end
