class HomeController < ApplicationController

  def show
    service   = ApiService.new(session[:token])
    user_data = service.user_hash
    
    @user_name = user_data[:login]
    @avatar    = user_data[:avatar_url]
  end
end
