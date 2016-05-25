class User
  attr_reader :avatar_url, :name, :login, :email, :created_at,
              :followers, :following

  def initialize(session_token)
    @service  = GithubService.new(session_token)
    user_hash = @service.user_hash

    @avatar_url = user_hash[:avatar_url]
    @name       = user_hash[:name]
    @login      = user_hash[:login]
    @email      = user_hash[:email]
    @created_at = user_hash[:created_at]
    @followers  = user_hash[:followers]
    @following  = user_hash[:following]
  end

  def repos
    @service.repos_hash.map do |repo_data|
      Repo.new(repo_data)
    end
  end

end
