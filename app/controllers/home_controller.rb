class HomeController < ApplicationController

  def show
    if session[:token]
      token = session[:token]
      @user = User.new(token)
    end
  end

  def search
    service = GithubService.new(session[:token])
    terms   = params["q"]
    results = service.search(terms)
    @total  = results[:total_count]

    @search_items = results[:items].map do |search_data|
      OpenStruct.new(search_data)
    end
  end
end
