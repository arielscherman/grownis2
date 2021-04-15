class Market::Endpoint::Bluelytics < Market::Endpoint::Base
  URL = "https://api.bluelytics.com.ar/v2/latest".freeze

  def fetch!(value_to_fetch)
    if(raw_value = json_response.fetch(value_to_fetch, {}).fetch("value_buy"))
      raw_value.to_f
    end
  rescue StandardError => ex
    Rollbar.warning("Couldn't fetch #{value_to_fetch} from Bluelytics", ex: ex, json_response: json_response)
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
