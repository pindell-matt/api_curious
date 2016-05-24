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

  def parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end

end
