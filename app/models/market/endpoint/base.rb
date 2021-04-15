class Market::Endpoint::Base
  def fetch!(value_to_fetch)
    find_value_in_response(json_response, value_to_fetch)
  rescue StandardError => ex
    Rollbar.warning("Couldn't fetch #{value_to_fetch} from #{self.class.name}", ex: ex, json_response: json_response)
    nil
  end

  def source_url
    raise NoMethodError, 'The endpoint class must specify the source to fetch the data from'
  end

  def find_value_in_response(_json_response, _value_to_fetch)
    raise NoMethodError, 'The endpoint class must specify how to fetch the value from the json response'
  end

  private

  def json_response
    @json_response ||= begin
      response = HTTParty.get(source_url)
      JSON.parse(response.body)
    end
  end
end
