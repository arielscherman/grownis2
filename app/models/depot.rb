class Depot < ApplicationRecord
  belongs_to :currency
  belongs_to :user

  validates :name, presence: true

  delegate :symbol, to: :currency, prefix: true
end
