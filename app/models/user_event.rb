class UserEvent
  include ActionView::Helpers::DateHelper

  attr_reader :type, :repo

  def initialize(event_hash)
    @type       = event_hash[:type]
    @repo       = event_hash[:repo][:name]
    @created_at = event_hash[:created_at]
  end

  def create_time_in_words
    distance_of_time_in_words_to_now(@created_at.to_time)
  end

  def html_url
    "https://github.com/#{@repo}"
  end
end
