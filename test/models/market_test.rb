require 'test_helper'

class MarketTest < ActiveSupport::TestCase
  def described_class; Market; end

  def test_returns_first_result_without_trying_a_secondary
    dolar_blue = rates(:ars_in_dolar_blue)

    described_class::Endpoint::Dolarsi.any_instance.stubs(:fetch!).returns(115.50)

    described_class::Endpoint::Bluelytics.any_instance.expects(:fetch!).never

    assert_equal described_class.new.fetch_daily_value_for_rate(dolar_blue), 115.50
  end

  def test_returns_secondary_result_if_first_endpoint_fails
    dolar_blue = rates(:ars_in_dolar_blue)

    described_class::Endpoint::Dolarsi.any_instance.stubs(:fetch!).returns(nil)
    described_class::Endpoint::Bluelytics.any_instance.stubs(:fetch!).returns(115.50)

    assert_equal described_class.new.fetch_daily_value_for_rate(dolar_blue), 115.50
  end

  def test_raises_error_if_no_endpoint_works
    dolar_blue = rates(:ars_in_dolar_blue)

    described_class::Endpoint::Dolarsi.any_instance.stubs(:fetch!).returns(nil)
    described_class::Endpoint::Bluelytics.any_instance.stubs(:fetch!).returns(nil)

    assert_raises described_class::ValueNotFoundError do
      described_class.new.fetch_daily_value_for_rate(dolar_blue)
    end
  end

  def test_raises_error_when_rate_key_not_defined
    new_rate     = rates(:ars_in_dolar_blue)
    new_rate.key = :not_defined_key

    assert_raises KeyError do
      described_class.new.fetch_daily_value_for_rate(new_rate)
    end
  end

  def test_fetching_multiple_values_from_same_source_does_not_retrigger_http_calls
    btc = rates(:btc_in_usd)
    eth = rates(:eth_in_usd)

    response = '{"bitcoin":{"usd":9159.58}, "ethereum":{"usd": 1244.50}}'

    stub_request(:any, Market::Endpoint::Coingecko::URL).to_return(body: response)

    market = described_class.new
    market.fetch_daily_value_for_rate(btc)
    market.fetch_daily_value_for_rate(eth)

    assert_requested :get, Market::Endpoint::Coingecko::URL, times: 1
  end
end
