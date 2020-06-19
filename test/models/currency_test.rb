require 'test_helper'

class CurrencyTest < ActiveSupport::TestCase
  def test_presence_of_name
    currency = currencies(:ars)
    currency.name = ""

    currency.valid?
    assert currency.errors.details.has_key?(:name)
  end

  def test_presence_of_symbol
    currency = currencies(:ars)
    currency.symbol = ""

    currency.valid?
    assert currency.errors.details.has_key?(:symbol)
  end

  def test_has_many_depots
    assert_instance_of Depot, currencies(:ars).depots.first
  end

  def test_has_many_rates
    assert_instance_of Rate, currencies(:ars).rates.first
  end
end
