require 'test_helper'

class Rate::Value::Market::BluelyticsEndpointTest < ActiveSupport::TestCase
  def described_class; Rate::Value::Market::BluelyticsEndpoint; end

  VALID_RESPONSE_EXAMPLE = '{"blue":{"value_avg":122.00,"value_sell":126.00,"value_buy":118.55}}'.freeze

  def test_fetch_returns_parsed_value
    stub_request(:any, described_class::URL).to_return(body: VALID_RESPONSE_EXAMPLE)

    assert_equal described_class.new.fetch!("blue"), 118.55
  end

  def test_non_existing_value_returns_nil
    stub_request(:any, described_class::URL).to_return(body: VALID_RESPONSE_EXAMPLE)

    assert_nil described_class.new.fetch!("Invalid Name")
  end

  def test_response_is_not_a_hash_returns_nil
    response = '[{"blue":{"value_avg":122.00,"value_sell":126.00,"value_buy":118.55}}]' # not hash
    stub_request(:any, described_class::URL).to_return(body: response)

    assert_nil described_class.new.fetch!("blue")
  end

  def test_response_without_expected_key_returns_nil
    response = '{"blue":{"value_avg":122.00,"value_sell":126.00}}' # missing "value_buy"

    stub_request(:any, described_class::URL).to_return(body: response)

    assert_nil described_class.new.fetch!("blue")
  end
end
