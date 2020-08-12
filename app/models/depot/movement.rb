class Depot::Movement < ApplicationRecord
  belongs_to :depot

  validates :date, presence: true
  validates :total_cents, presence: true, numericality: { other_than: 0 }

  before_validation :set_current_date
  before_save :update_depot
  before_destroy :substract_from_depot

  def total=(new_total)
    self.total_cents = new_total.to_f * 100
  end

  def total
    return 0.0 if total_cents.nil?
    total_cents / 100.0
  end

  private

  def set_current_date
    self.date ||= Date.current
  end

  def update_depot
    depot.update_total!(total_cents - total_cents_was.to_i)
  end

  def substract_from_depot
    depot.update_total!(-total_cents.to_i)
  end
end
