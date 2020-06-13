require 'test_helper'

class DepotTest < ActiveSupport::TestCase
  def test_presence_of_name
    depot = depots(:national_bank)
    depot.name = ""

    depot.valid?
    assert depot.errors.details.has_key?(:name)
  end

  def test_presence_of_currency
    depot = depots(:national_bank)
    depot.currency = nil

    depot.valid?
    assert depot.errors.details.has_key?(:currency)
  end

  def test_belongs_to_currency
    assert_instance_of Currency, depots(:national_bank).currency
  end

  def test_belongs_to_user
    assert_instance_of User, depots(:national_bank).user
  end

  def test_has_many_movements
    assert_instance_of Depot::Movement, depots(:national_bank).movements.first
  end

  def test_presence_of_rate
    depot = depots(:national_bank)
    depot.rate = nil

    depot.valid?
    assert depot.errors.details.has_key?(:rate)
  end

  def test_delegate_symbol_to_currency
    assert_equal depots(:national_bank).currency_symbol, "ARS"
  end
end
