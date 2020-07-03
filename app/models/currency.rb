class Currency < ApplicationRecord
  has_many :depots, dependent: :restrict_with_error, inverse_of: :currency
  has_many :rates, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :symbol, presence: true, uniqueness: true

  def usd?
    symbol == "USD"
  end
end
