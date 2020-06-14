class Rate < ApplicationRecord
  has_many :values, class_name: "Rate::Value", inverse_of: :rate, dependent: :destroy
  has_many :depots, inverse_of: :rate, dependent: :restrict_with_exception

  validates :name, presence: true
  validates :key, presence: true

  def fetch_daily_value(market = ::Rate::Value::Market.new)
    market.fetch_daily_value_for_rate(self)
  end
end
