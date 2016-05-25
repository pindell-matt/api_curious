class HomeController < ApplicationController

  def show
    if session[:token]
      token = session[:token]
      @user = User.new(token)
    end
  end
end
