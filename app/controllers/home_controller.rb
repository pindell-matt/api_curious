class HomeController < ApplicationController

  def show
    if session[:token]
      token     = session[:token]
      service   = GithubService.new(token)
      user_data = service.user_hash

      @user = User.new(user_data)
      # don't create @repo - add
      # presernters
      @repos = Repo.all(token)
    end

  end
end
