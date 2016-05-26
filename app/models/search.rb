class Search
  attr_reader :total, :search_items

  def initialize(token, terms)
    service       = GithubService.new(token)
    results       = service.search(terms)
    @total        = results[:total_count]
    @search_items = all_search_items(results)
  end

  def all_search_items(results)
    results[:items].map do |search_data|
      OpenStruct.new(search_data)
    end
  end

end
