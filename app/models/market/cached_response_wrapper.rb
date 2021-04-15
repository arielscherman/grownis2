class Market::CachedResponseWrapper
  def initialize(fetcher)
    @fetcher = fetcher

    @fetcher.on_json_response = lambda do |json_response|
      @cached_response = json_response
    end 
  end

  def fetch!(value_to_fetch)
    @fetcher.fetch!(value_to_fetch, @cached_response)
  end
end
