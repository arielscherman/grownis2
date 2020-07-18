class Rate::Value::Market
  class ValueNotFoundError < StandardError; end
  VALUE_NOT_FOUND_ERROR_MESSAGE = "We couldn't find the value for %s on any Endpoint"

  MAPPINGS = {
    ars_in_dolar_blue: { DolarsiEndpoint    => "Dolar Blue",
                         BluelyticsEndpoint => "blue" },
    ars_in_dolar_ccl:  { DolarsiEndpoint => "Dolar Contado con Liqui" },
    ars_in_dolar_mep:  { DolarsiEndpoint => "Dolar Bolsa" },
    btc_in_usd:        { CoingeckoEndpoint => "bitcoin" },
    eth_in_usd:        { CoingeckoEndpoint => "ethereum" }
  }.freeze

  def fetch_daily_value_for_rate(rate)
    fetch_from_endpoint(rate) || raise(ValueNotFoundError, format(VALUE_NOT_FOUND_ERROR_MESSAGE, rate.key))
  end

  private

  def fetch_from_endpoint(rate)
    value = nil

    endpoints_for_key(rate.key.to_sym).each do |endpoint_class, endpoint_value_to_fetch|
      value = endpoints(endpoint_class).fetch!(endpoint_value_to_fetch)
      break if value
    end

    value
  end

  def endpoints_for_key(rate_key)
    MAPPINGS.fetch(rate_key)
  end

  # Returns the instance for the given endpoint (if initialized already)
  # to prevent triggering multiple requests to each.
  #
  def endpoints(klass)
    @endpoints ||= Hash.new { |h, key| h[key] = key.new }
    @endpoints[klass]
  end
end
