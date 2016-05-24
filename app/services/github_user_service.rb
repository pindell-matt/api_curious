class GithubUserService

  def initialize(token)
    @connection = Faraday.new(url: "https://api.github.com")
    @connection.headers["Authorization"] = "token #{token}"
  end

  def get_user
    @connection.get "user"
  end

  def user_hash
    parse(get_user)
  end

  def get_followers
    @connection.get "user/followers"
  end

  def followers_hash
    parse(get_followers)
  end

  def user_followers_count
    parse(get_followers).count
  end

  private
    def parse(response)
      JSON.parse(response.body, symbolize_names: true)
    end
end
