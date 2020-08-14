class Rate::Value < ApplicationRecord
  belongs_to :rate

  validates :value, numericality: true
  validates :rate, uniqueness: { scope: :date }

  def informative_value
    if rate.measured_in_currency?
      (1 / value).round(2)
    else
      value.round(2)
    end
  end
end
