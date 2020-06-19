require 'test_helper'

class Rate::Value::Market::DolarsiEndpointTest < ActiveSupport::TestCase
  def described_class; Rate::Value::Market::DolarsiEndpoint; end

  VALID_RESPONSE_EXAMPLE = '[{"casa":{"compra":"116,450","venta":"126,000","nombre":"Dolar Blue","variacion":"2,440"}}]'.freeze

  def test_fetch_returns_parsed_value
    stub_request(:any, described_class::URL).to_return(body: VALID_RESPONSE_EXAMPLE)

    assert_equal described_class.new.fetch!("Dolar Blue"), (1/116.450)
  end

  def test_fetching_multiple_values_does_not_trigger_new_request
    response = '[{"casa":{"compra":"116,450","venta":"126,000","nombre":"Dolar Blue","variacion":"2,440"}}, {"casa":{"compra":"108,120","venta":"107,750","nombre":"Dolar Bolsa","variacion":"0,510"}}]'

    stub_request(:any, described_class::URL).to_return(body: VALID_RESPONSE_EXAMPLE)

    endpoint = described_class.new
    endpoint.fetch!("Dolar Blue")
    endpoint.fetch!("Dolar Bolsa")

    assert_requested :get, described_class::URL, times: 1
  end

  def test_non_existing_value_returns_nil
    stub_request(:any, described_class::URL).to_return(body: VALID_RESPONSE_EXAMPLE)

    assert_nil described_class.new.fetch!("Invalid Name")
  end

  def test_response_is_not_an_array_returns_nil
    response = '{"casa":{"compra":"116,450","venta":"126,000","nombre":"Dolar Blue","variacion":"2,440"}}' # not array
    stub_request(:any, described_class::URL).to_return(body: response)

    assert_nil described_class.new.fetch!("Dolar Blue")
  end

  def test_response_without_expected_key_returns_nil
    response = '[{"casa":{"venta":"126,000","nombre":"Dolar Blue","variacion":"2,440"}}]' # missing "compra"

    stub_request(:any, described_class::URL).to_return(body: response)

    assert_nil described_class.new.fetch!("Dolar Blue")
  end
end
