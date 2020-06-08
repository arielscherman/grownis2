require 'test_helper'

class MovementTest < ActiveSupport::TestCase
  def test_presence_of_depot
    movement = movements(:deposit)
    movement.depot = nil

    movement.valid?
    assert movement.errors.details.has_key?(:depot)
  end

  def test_presence_of_date
    movement = movements(:deposit)
    movement.date = nil

    movement.valid?
    assert movement.errors.details.has_key?(:date)
  end

  def test_presence_of_total_cents
    movement = movements(:deposit)
    movement.total_cents = nil

    movement.valid?
    assert movement.errors.details.has_key?(:total_cents)
  end

  def test_belongs_to_currency
    assert_instance_of Currency, depots(:national_bank).currency
  end
end
