class Activity
  include ActionView::Helpers::DateHelper

  attr_reader :type, :actor, :repo

  def initialize(activity_data)
    @type       = activity_data[:type]
    @actor      = activity_data[:actor][:login]
    @repo       = activity_data[:repo][:name]
    @created_at = activity_data[:created_at]
  end

  def update_time_in_words
    distance_of_time_in_words_to_now(@created_at.to_time)
  end

  def html_url
    "https://github.com/#{@repo}"
  end
end
