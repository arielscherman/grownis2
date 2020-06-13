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
end
