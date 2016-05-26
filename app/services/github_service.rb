class GithubService

  def initialize(token)
    @_connection = Faraday.new(url: "https://api.github.com")
    @_connection.headers["Authorization"] = "token #{token}"
  end

  def login
    user_hash[:login]
  end

  def get_user
    connection.get "user"
  end

  def user_hash
    parse(get_user)
  end

  def get_repos
    connection.get "user/repos", { :per_page => 100 }
  end

  def repos_hash
    parse(get_repos)
  end

  def get_starred_repos
    connection.get "user/starred"
  end

  def starred_repos_hash
    parse(get_starred_repos)
  end

  def get_organizations
    connection.get "users/#{login}/orgs"
  end

  def organizations_hash
    parse(get_organizations)
  end

  def get_recent_events
    connection.get "users/#{login}/events"
  end

  def recent_events_hash
    parse(get_recent_events)
  end

  def get_recent_activity_of_followed
    connection.get "users/#{login}/received_events"
  end

  def recent_activity_of_followed_hash
    parse(get_recent_activity_of_followed)
  end

  def get_yearly_contributions
    that = connection.get "users/#{login}"
    page = connection.get parse(that)[:html_url]
    doc  = Nokogiri::HTML(page.body)
    doc.search('.flush h3').last.text.strip
  end

  private
    def parse(response)
      JSON.parse(response.body, symbolize_names: true)
    end

    def connection
      @_connection
    end
end
