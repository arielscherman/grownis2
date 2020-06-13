class Rate::Value < ApplicationRecord
  belongs_to :currency
  belongs_to :rate

  validates :value, numericality: true
end
