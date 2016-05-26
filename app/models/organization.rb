class Organization
  attr_reader :login, :avatar_url

  def initialize(organization_data)
    @login      = organization_data[:login]
    @avatar_url = organization_data[:avatar_url]
  end

  def html_url
    "https://github.com/#{login}"
  end
end
