require 'test_helper'

class Market::Endpoint::DolarsiTest < ActiveSupport::TestCase
  def described_class; Market::Endpoint::Dolarsi; end

  VALID_RESPONSE_EXAMPLE = '[{"casa":{"compra":"116,450","venta":"126,000","nombre":"Dolar Blue","variacion":"2,440"}}]'.freeze

  def test_fetch_returns_parsed_value
    stub_request(:any, described_class::URL).to_return(body: VALID_RESPONSE_EXAMPLE)

    assert_equal described_class.new.fetch!("Dolar Blue"), (1/116.450)
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
