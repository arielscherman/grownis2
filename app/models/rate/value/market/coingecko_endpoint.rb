class Rate::Value::Market::CoingeckoEndpoint
  URL = "https://api.coingecko.com/api/v3/simple/price?ids=bitcoin%2Cethereum&vs_currencies=usd".freeze

  def fetch!(value_to_fetch)
    if(raw_value = json_response.fetch(value_to_fetch, {}).fetch("usd"))
      raw_value.to_f
    end
  rescue StandardError => ex
    Rollbar.warning("Couldn't fetch #{value_to_fetch} from Coingecko", ex: ex, json_response: json_response)
    nil
  end


  private

  def json_response
    @json_response ||= begin
      response = HTTParty.get(URL)
      JSON.parse(response.body)
    end
  end
end
