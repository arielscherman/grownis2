require 'test_helper'

class Rate::Value::Market::CoingeckoEndpointTest < ActiveSupport::TestCase
  def described_class; Rate::Value::Market::CoingeckoEndpoint; end

  VALID_RESPONSE_EXAMPLE = '{"bitcoin":{"usd":9159.58}}'.freeze

  def test_fetch_returns_parsed_value
    stub_request(:any, described_class::URL).to_return(body: VALID_RESPONSE_EXAMPLE)

    assert_equal described_class.new.fetch!("bitcoin"), 9159.58
  end

  def test_non_existing_value_returns_nil
    stub_request(:any, described_class::URL).to_return(body: VALID_RESPONSE_EXAMPLE)

    assert_nil described_class.new.fetch!("Invalid Name")
  end

  def test_response_is_not_a_hash_returns_nil
    response = '[{"bitcoin":{"usd":9159.58}}]' # not hash
    stub_request(:any, described_class::URL).to_return(body: response)

    assert_nil described_class.new.fetch!("bitcoin")
  end

  def test_response_without_expected_key_returns_nil
    response = '{"bitcoin":{"wrong_key":9159.58}}' # missing "usd"

    stub_request(:any, described_class::URL).to_return(body: response)

    assert_nil described_class.new.fetch!("bitcoin")
  end
end
