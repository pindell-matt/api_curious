class Result
  attr_reader :name, :html_url, :owner, :description

  def initialize(result_hash)
    @name        = result_hash[:name]
    @html_url    = result_hash[:html_url]
    @owner       = result_hash[:owner][:login]
    @description = result_hash[:description]
  end

end
