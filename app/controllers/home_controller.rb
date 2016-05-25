class HomeController < ApplicationController

  def show
    service   = GithubUserService.new(session[:token])
    user_data = service.user_hash

    @user = User.new(user_data)
    # @user = User.save(user_data)
    # format hash so that I have everything I need bundled in key, value
    # pairs within User

    # require "pry"
    # binding.pry

    # @user_name = user_data[:login]
    # @avatar    = user_data[:avatar_url]
  end
end
