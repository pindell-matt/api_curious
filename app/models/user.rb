class User
  attr_reader :avatar_url, :name, :login, :email, :created_at,
              :followers, :following, :starred

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
    @starred    = @service.starred_repos_hash.count
  end

  def repos
    @service.repos_hash.map do |repo_data|
      Repo.new(repo_data)
    end
  end

  def events
    @service.recent_events_hash.map do |event_data|
      UserEvent.new(event_data)
    end
  end

  def organizations
    @service.organizations_hash.map do |organization_data|
      Organization.new(organization_data)
    end
  end

  def activity_of_followed
    @service.recent_activity_of_followed_hash.map do |activity_data|
      Activity.new(activity_data)
    end
  end

  def yearly_contributions
    @service.get_yearly_contributions
  end

end
