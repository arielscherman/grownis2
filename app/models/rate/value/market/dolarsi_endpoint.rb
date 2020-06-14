class Rate::Value::Market::DolarsiEndpoint
  URL = "https://www.dolarsi.com/api/api.php?type=valoresprincipales".freeze

  def fetch!(rate_key)
    @values ||= Hash.new { |h, key| h[key] = parse_value(key) }
    @values[rate_key]
  end

  private

  def parse_value(key)
    if(raw_value = values_for_key(key).fetch("compra", nil))
      parse_number(raw_value)
    end
  end

  def values_for_key(key)
    json_response.map { |h| h["casa"] }.find { |h| h["nombre"] == key }.presence || {}
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
