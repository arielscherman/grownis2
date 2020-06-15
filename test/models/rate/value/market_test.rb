require 'test_helper'

class Rate::Value::MarketTest < ActiveSupport::TestCase
  def described_class; Rate::Value::Market; end

  def test_returns_first_result_without_trying_a_secondary
    dolar_blue = rates(:ars_in_dolar_blue)

    described_class::DolarsiEndpoint.any_instance.stubs(:fetch!).returns(115.50)

    described_class::BluelyticsEndpoint.any_instance.expects(:fetch!).never

    assert_equal described_class.new.fetch_daily_value_for_rate(dolar_blue), 115.50
  end

  def test_returns_secondary_result_if_first_endpoint_fails
    dolar_blue = rates(:ars_in_dolar_blue)

    described_class::DolarsiEndpoint.any_instance.stubs(:fetch!).returns(nil)
    described_class::BluelyticsEndpoint.any_instance.stubs(:fetch!).returns(115.50)

    assert_equal described_class.new.fetch_daily_value_for_rate(dolar_blue), 115.50
  end

  def test_raises_error_if_no_endpoint_works
    dolar_blue = rates(:ars_in_dolar_blue)

    described_class::DolarsiEndpoint.any_instance.stubs(:fetch!).returns(nil)
    described_class::BluelyticsEndpoint.any_instance.stubs(:fetch!).returns(nil)

    assert_raises described_class::ValueNotFoundError do
      described_class.new.fetch_daily_value_for_rate(dolar_blue)
    end
  end

  def test_raises_error_when_rate_key_not_defined
    new_rate     = rates(:dolar_blue)
    new_rate.key = :not_defined_key

    assert_raises KeyError do
      described_class.new.fetch_daily_value_for_rate(new_rate)
    end
  end
end
