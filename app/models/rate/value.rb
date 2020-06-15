class Rate::Value < ApplicationRecord
  belongs_to :rate

  validates :value, numericality: true
  validates :rate, uniqueness: { scope: :date }
end
