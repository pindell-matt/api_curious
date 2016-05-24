class SessionsController < ApplicationController
  before_action :oauth_service

  def create
    # oauth_service = GithubOauthService.new
    # oauth_service.get_client_code

    redirect_to "https://github.com/login/oauth/authorize?client_id=#{ENV["GITHUB_CLIENT_ID"]}"
  end

  def callback
    code            = params['code']
    session[:token] = oauth_service.get_access_token(code)
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
