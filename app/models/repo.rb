class Repo
  include ActionView::Helpers::DateHelper

  attr_reader :name, :owner, :html_url, :description

  def initialize(repo_hash)
    @name        = repo_hash[:name]
    @owner       = repo_hash[:owner][:login]
    @html_url    = repo_hash[:html_url]
    @description = repo_hash[:description]
    @updated_at  = repo_hash[:updated_at]
  end

  def update_time_in_words
    distance_of_time_in_words_to_now(@updated_at.to_time)
  end
end
