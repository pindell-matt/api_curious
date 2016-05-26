class HomeController < ApplicationController

  def show
    if session[:token]
      token = session[:token]
      @user = User.new(token)
    end
  end

  def search
    if session[:token]
      terms    = params["q"]
      @results = Search.new(session[:token], terms)
    else
      flash[:notice] = "Please Login in order to Search!"
      redirect_to root_path
    end

    # service = GithubService.new(session[:token])
    # terms   = params["q"]
    # results = service.search(terms)
    # @total  = results[:total_count]
    #
    # @search_items = results[:items].map do |search_data|
    #   OpenStruct.new(search_data)
    # end
  end
end
