class SessionsController < ApplicationController
  before_action :oauth_service

  def create
    redirect_to "https://github.com/login/oauth/authorize?client_id=#{ENV["GITHUB_CLIENT_ID"]}"
  end

  def callback
    session_code    = params['code']
    session[:token] = oauth_service.get_access_token(session_code)
    redirect_to root_path
  end

  def destroy
    session.clear
    redirect_to root_path
  end

  private
    def oauth_service
      GithubOauthService.new
    end
end
