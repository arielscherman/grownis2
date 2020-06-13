class Rate < ApplicationRecord
  has_many :values, class_name: "Rate::Value", inverse_of: :rate, dependent: :destroy
  has_many :depots, inverse_of: :rate, dependent: :restrict_with_exception
end
