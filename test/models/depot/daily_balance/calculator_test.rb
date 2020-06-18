require 'test_helper'

class Depot::DailyBalance::CalculatorTest < ActiveSupport::TestCase
  def described_class; Depot::DailyBalance::Calculator; end

  test "#variation_between calculates ratio" do
    calculator = described_class.new
    assert_equal calculator.variation_between(100, 120), 20.0
    assert_equal calculator.variation_between(110, 105), -4.545454545454546
  end

  test "#variation_between returns zero when any value is empty" do
    calculator = described_class.new
    assert_equal calculator.variation_between(nil, 120), 0.0
    assert_equal calculator.variation_between(110, nil), 0.0
  end
end
