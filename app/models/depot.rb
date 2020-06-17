class Depot < ApplicationRecord
  belongs_to :currency
  belongs_to :rate, optional: true
  belongs_to :user
  belongs_to :latest_daily_balance, class_name: "Depot::DailyBalance", optional: true

  has_many :movements, dependent: :destroy

  validates :name, presence: true
  validates :rate, presence: true, if: :currency_has_rates?

  delegate :symbol, to: :currency, prefix: true

  def update_total!(amount_in_cents)
    update!(cached_total_cents: cached_total_cents + amount_in_cents)
  end

  def rate_required?
    return false if currency_id.blank?
    currency.rates.any?
  end

  private

  def rate_or_currency_changed?
    currency_id_changed? || rate_id_changed?
  end

  def currency_has_rates?
    return false unless currency_id_changed? || rate_id_changed?
    rate_required?
  end
end
