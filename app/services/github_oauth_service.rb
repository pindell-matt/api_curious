class GithubOauthService

  def initialize
    @connection = Faraday.new(url: "https://github.com")
  end

  def get_client_code
    @connection.get "login/oauth/authorize?client_id=#{ENV["GITHUB_CLIENT_ID"]}"
  end

  def get_access_token(code)
    response = @connection.post '/login/oauth/access_token', {
      client_id:     ENV["GITHUB_CLIENT_ID"],
      client_secret: ENV["GITHUB_CLIENT_SECRET"],
      code:          code
    }

    # cgi library
    access_token = response.env['body'].split('&').first.split('=').last
  end

end
