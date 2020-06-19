class Currency < ApplicationRecord
  has_many :depots, dependent: :restrict_with_error
  has_many :rates, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :symbol, presence: true, uniqueness: true
end
