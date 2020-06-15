class Depot < ApplicationRecord
  belongs_to :currency
  belongs_to :rate
  belongs_to :user
  belongs_to :latest_daily_balance, class_name: "Depot::DailyBalance", optional: true

  has_many :movements, dependent: :destroy

  validates :name, presence: true

  delegate :symbol, to: :currency, prefix: true

  def update_total!(amount_in_cents)
    update!(cached_total_cents: cached_total_cents + amount_in_cents)
  end
end
