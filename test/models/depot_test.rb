require 'test_helper'

class DepotTest < ActiveSupport::TestCase
  #
  # Associations
  #
  def test_belongs_to_currency
    assert_instance_of Currency, depots(:national_bank).currency
  end

  def test_belongs_to_user
    assert_instance_of User, depots(:national_bank).user
  end

  def test_belongs_to_rate
    assert_instance_of Rate, depots(:national_bank).rate
  end

  def test_has_many_movements
    assert_instance_of Depot::Movement, depots(:national_bank).movements.first
  end

  #
  # Validations
  #
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

  def test_require_rate_if_currency_has_one
    depot = depots(:national_bank)
    depot.rate = nil

    depot.valid?
    assert depot.errors.details.has_key?(:rate)
  end

  def test_does_not_require_rate_if_currency_does_not_have_one
    depot = depots(:american_bank)
    depot.rate = nil

    assert depot.valid?
  end

  #
  # Delegations
  #
  def test_delegate_symbol_to_currency
    assert_equal depots(:national_bank).currency_symbol, "ARS"
  end

  #
  # Instance methods
  #
  test "#rate_required? is false when currency is blank" do
    depot = depots(:national_bank)
    depot.currency = nil

    refute depot.rate_required?
  end

  test "#rate_required? is false when currency has no rates" do
    refute depots(:american_bank).rate_required?
  end

  test "#rate_required? is true when currency has rates" do
    assert depots(:national_bank).rate_required?
  end
end
