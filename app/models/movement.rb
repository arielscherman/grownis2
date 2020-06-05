class Movement < ApplicationRecord
  belongs_to :depot

  validates :date, presence: true
  validates :total_cents, presence: true
end
