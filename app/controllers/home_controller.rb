class HomeController < ApplicationController

  def show
    token     = session[:token]
    service   = GithubUserService.new(token)
    user_data = service.user_hash

    @user = User.new(user_data)
    # @user = User.save(user_data)
    # format hash so that I have everything I need bundled in key, value
    # pairs within User

    @repos = Repo.all(token)

  end
end
