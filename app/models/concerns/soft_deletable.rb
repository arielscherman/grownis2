module SoftDeletable
  extend ActiveSupport::Concern

  included do
    scope :active, -> { where(deleted_at: nil) }
    scope :deleted, -> { where.not(deleted_at: nil) }
  end

  def soft_delete!
    update!(deleted_at: Time.current)
  end

  def soft_deleted?
    deleted_at.present?
  end
end
