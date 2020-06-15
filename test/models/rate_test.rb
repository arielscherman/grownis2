require 'test_helper'

class RateTest < ActiveSupport::TestCase
  def test_presence_of_name
    rate = rates(:ars_in_dolar_blue)
    rate.name = ""

    rate.valid?
    assert rate.errors.details.has_key?(:name)
  end

  def test_presence_of_currency
    rate = rates(:ars_in_dolar_blue)
    rate.key = ""

    rate.valid?
    assert rate.errors.details.has_key?(:key)
  end


  def test_has_many_values
    assert_instance_of Rate::Value, rates(:ars_in_dolar_blue).values.first
  end

  def test_has_many_depots
    assert_instance_of Depot, rates(:ars_in_dolar_blue).depots.first
  end

  def test_presence_of_currency
    rate = rates(:ars_in_dolar_blue)
    rate.currency = nil

    rate.valid?
    assert rate.errors.details.has_key?(:currency)
  end

  def test_belongs_to_currency
    assert_instance_of Currency, rates(:ars_in_dolar_blue).currency
  end

  def test_fetch_daily_value_creates_a_value_for_today_rate
    market_stub = Rate::Value::Market.new
    rate        = rates(:ars_in_dolar_blue)

    market_stub.stubs(:fetch_daily_value_for_rate).with(rate).returns(0.008)

    assert_difference "Rate::Value.count", +1 do
      rate.fetch_daily_value!(market_stub)
    end

    created_value = rate.values.last
    assert_equal created_value.value, 0.008
    assert_equal created_value.date, Time.zone.today
  end

  def test_fetch_daily_value_does_not_duplicate_value_if_already_created
    market_stub = Rate::Value::Market.new
    rate        = rates(:ars_in_dolar_blue)
    rate.values.create!(value: 0.008, date: Time.zone.today)

    market_stub.stubs(:fetch_daily_value_for_rate).with(rate).returns(0.012)

    assert_no_difference "Rate::Value.count" do
      rate.fetch_daily_value!(market_stub)
    end

    assert_equal rate.values.last.value, 0.008 # hasn't changed
  end
end
