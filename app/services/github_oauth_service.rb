class GithubOauthService

  def initialize
    @connection = Faraday.new(url: "https://github.com")
  end

  def get_access_token(session_code)
    response = @connection.post '/login/oauth/access_token', {
      client_id:     ENV["GITHUB_CLIENT_ID"],
      client_secret: ENV["GITHUB_CLIENT_SECRET"],
      code:          session_code
    }
    access_token = response.env['body'].split('&').first.split('=').last
  end

end
