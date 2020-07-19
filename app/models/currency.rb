class Currency < ApplicationRecord
  has_many :depots, dependent: :restrict_with_error, inverse_of: :currency
  has_many :rates, dependent: :destroy

  belongs_to :category, class_name: "Currency::Category", foreign_key: :currency_category_id

  validates :name, presence: true, uniqueness: true
  validates :symbol, presence: true, uniqueness: true

  def usd?
    symbol == "USD"
  end

  def label
    "#{symbol} - #{name}"
  end
end
