require 'test_helper'

class Rate::ValueTest < ActiveSupport::TestCase
  def test_presence_of_value
    rate_value = rate_values(:dolar_blue_1_day_ago)
    rate_value.value = nil

    rate_value.valid?
    assert rate_value.errors.details.has_key?(:value)
  end

  def test_presence_of_currency
    rate_value = rate_values(:dolar_blue_1_day_ago)
    rate_value.currency = nil

    rate_value.valid?
    assert rate_value.errors.details.has_key?(:currency)
  end

  def test_belongs_to_currency
    assert_instance_of Currency, rate_values(:dolar_blue_1_day_ago).currency
  end

  def test_presence_of_rate
    rate_value = rate_values(:dolar_blue_1_day_ago)
    rate_value.rate = nil

    rate_value.valid?
    assert rate_value.errors.details.has_key?(:rate)
  end

  def test_belongs_to_rate
    assert_instance_of Rate, rate_values(:dolar_blue_1_day_ago).rate
  end
end
