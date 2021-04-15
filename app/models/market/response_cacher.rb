class Rate::Value::Market::ResponseCacher
  def initialize(fetcher)
    @fetcher = fetcher
  end

  def fetch!(value_to_fetch)
  end

  private

  def cached_response
    @cached_response ||= @fetcher.fetch!
  end
end
