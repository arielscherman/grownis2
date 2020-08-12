require 'test_helper'

class Depot::MovementTest < ActiveSupport::TestCase
  def test_presence_of_depot
    movement = depot_movements(:deposit)
    movement.depot = nil

    movement.valid?
    assert movement.errors.details.has_key?(:depot)
  end

  def test_presence_of_total_cents
    movement = depot_movements(:deposit)
    movement.total_cents = nil

    movement.valid?
    assert movement.errors.details.has_key?(:total_cents)
  end

  def test_belongs_to_currency
    assert_instance_of Currency, depots(:national_bank).currency
  end

  def test_valid_total_cents
    movement = depot_movements(:deposit)
    movement.total_cents = 0

    movement.valid?
    assert movement.errors.details.has_key?(:total_cents)
  end

  def test_set_current_date
    movement = depot_movements(:deposit)
    movement.date = nil

    movement.valid?
    assert_not movement.errors.details.has_key?(:date)
  end
end
