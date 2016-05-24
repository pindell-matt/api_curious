class SessionsController < ApplicationController

  def create
    redirect_to "https://github.com/login/oauth/authorize?client_id=#{ENV["GITHUB_CLIENT_ID"]}"
  end

  def callback
    @code = params['code']

    connection = Faraday.new(url: 'https://github.com') do |faraday|
      faraday.request  :url_encoded
      faraday.response :logger
      faraday.adapter  Faraday.default_adapter
    end

    response = connection.post '/login/oauth/access_token', {
      client_id:     ENV["GITHUB_CLIENT_ID"],
      client_secret: ENV["GITHUB_CLIENT_SECRET"],
      code:          @code
    }

    # must be a better way of getting this with JSON.parse
    access_token = response.env['body'].split('&').first.split('=').last
    session[:token] = access_token
    # now need to include it in the Authorization Header

      # testing with access_token
      # conn = Faraday.new(url: 'https://api.github.com') do |faraday|
      #   faraday.request  :url_encoded
      #   faraday.response :logger
      #   faraday.adapter  Faraday.default_adapter
      # end
      #
      # user      = conn.get '/user', { access_token: "#{access_token}" }
      # json_user = JSON.parse(user.body)
      # user_name = json_user["login"]
      # user_id   = json_user["id"]
      #
      # repos     = conn.get '/user/repos', { access_token: "#{access_token}" }
      # json_repo = JSON.parse(repos.body)
      # redirect_to "https://api.github.com/user?access_token=#{access_token}"

    redirect_to root_path
  end

  def destroy
    session.clear
    redirect_to root_path
  end

end
