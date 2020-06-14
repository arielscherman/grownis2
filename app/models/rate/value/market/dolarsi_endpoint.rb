class Rate::Value::Market::DolarsiEndpoint
  URL = "https://www.dolarsi.com/api/api.php?type=valoresprincipales".freeze

  def fetch!(value_to_fetch)
    if(raw_value = values_for_key(value_to_fetch).fetch("compra", nil))
      parse_number(raw_value)
    end
  end

  private

  def values_for_key(key)
    json_response.map { |h| h["casa"] }.find { |h| h["nombre"] == key }.presence || {}
  rescue TypeError
    # TODO: Log warning in case API response has changed
    {}
  end

  def parse_number(raw)
    raw.gsub(",", ".").to_f
  end

  def json_response
    @json_response ||= begin
      response = HTTParty.get(URL)
      JSON.parse(response.body)
    end
  end
end
