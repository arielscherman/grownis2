class Rate::Value::Market::BluelyticsEndpoint
  URL = "https://api.bluelytics.com.ar/v2/latest".freeze

  def fetch!(value_to_fetch)
    if(raw_value = json_response.fetch(value_to_fetch, {}).fetch("value_buy", nil))
      raw_value.to_f
    end
  rescue TypeError
    # TODO: Log a warn because the response might have changed
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
