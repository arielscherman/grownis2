require 'test_helper'

class RateTest < ActiveSupport::TestCase
  def test_presence_of_name
    rate = rates(:dolar_blue)
    rate.name = ""

    rate.valid?
    assert rate.errors.details.has_key?(:name)
  end

  def test_has_many_values
    assert_instance_of Rate::Value, rates(:dolar_blue).values.first
  end

  def test_has_many_depots
    assert_instance_of Depot, rates(:dolar_blue).depots.first
  end

  def test_presence_of_currency
    rate = rates(:dolar_blue)
    rate.currency = nil

    rate.valid?
    assert rate.errors.details.has_key?(:currency)
  end

  def test_belongs_to_currency
    assert_instance_of Currency, rates(:dolar_blue).currency
  end
end
