class Market
  VALUE_NOT_FOUND_ERROR_MESSAGE = "We couldn't find the value for %s on any Endpoint"

  ValueNotFoundError = Class.new(StandardError)

  SOURCE_FOR_RATE_KEYS = {
    ars_in_dolar_blue:    { Endpoint::Dolarsi    => "Dolar Blue",
                            Endpoint::Bluelytics => "blue" },
    ars_in_dolar_oficial: { Endpoint::Dolarsi    => "Dolar Oficial",
                            Endpoint::Bluelytics => "oficial" },
    ars_in_dolar_ccl:     { Endpoint::Dolarsi    => "Dolar Contado con Liqui" },
    ars_in_dolar_mep:     { Endpoint::Dolarsi    => "Dolar Bolsa" },
    btc_in_usd:           { Endpoint::Coingecko  => "bitcoin" },
    eth_in_usd:           { Endpoint::Coingecko  => "ethereum" }
  }.freeze

  def fetch_daily_value_for_rate(rate)
    fetch_from_endpoint(rate) || raise(ValueNotFoundError, format(VALUE_NOT_FOUND_ERROR_MESSAGE, rate.key))
  end

  private

  def fetch_from_endpoint(rate)
    value = nil

    endpoints_for_key(rate.key.to_sym).each do |endpoint_class, endpoint_value_to_fetch|
      value = endpoint_instance_for(endpoint_class).fetch!(endpoint_value_to_fetch)
      break if value
    end

    value
  end

  def endpoints_for_key(rate_key)
    SOURCE_FOR_RATE_KEYS.fetch(rate_key)
  end

  # Returns the instance for the given endpoint (if initialized already)
  # to prevent triggering multiple requests to each.
  #
  def endpoint_instance_for(klass)
    @endpoints ||= Hash.new do |h, endpoint_class|
      h[endpoint_class] = CachedResponseWrapper.new(endpoint_class.new)
    end

    @endpoints[klass]
  end
end
