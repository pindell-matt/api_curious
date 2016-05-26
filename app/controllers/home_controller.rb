class HomeController < ApplicationController

  def show
    if @token
      @user = User.new(@token)
    end
  end

  def search
    if @token
      terms    = params["q"]
      @results = Search.new(@token, terms)
    else
      flash[:notice] = "Please Login in order to Search!"
      redirect_to root_path
    end
  end
end
