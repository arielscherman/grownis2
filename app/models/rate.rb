class Rate < ApplicationRecord
  belongs_to :currency
  has_many :values, class_name: "Rate::Value", inverse_of: :rate, dependent: :destroy
  has_many :depots, inverse_of: :rate, dependent: :restrict_with_exception

  validates :name, presence: true
  validates :key, presence: true

  def fetch_daily_value!(market = ::Rate::Value::Market.new)
    daily_value = market.fetch_daily_value_for_rate(self)

    Rate::Value.find_or_create_by!(rate: self, date: Time.zone.today) do |new_rate_value|
      new_rate_value.value = daily_value
    end
  end
end
