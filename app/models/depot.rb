class Depot < ApplicationRecord
  belongs_to :currency
  belongs_to :user

  has_many :movements, dependent: :destroy

  validates :name, presence: true

  delegate :symbol, to: :currency, prefix: true
end
