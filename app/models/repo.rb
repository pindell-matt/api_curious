class Repo < OpenStruct

  def self.all(token)
    all_repos = service(token).repos_hash
    all_repos.map do |repo_hash|
      Repo.new(repo_hash)
    end
  end

  def self.service(token)
    GithubService.new(token)
  end

end
