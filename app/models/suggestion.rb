class Suggestion < ApplicationRecord
  belongs_to :user

  validates :description, presence: true

  after_create :notify_owner

  private

  def notify_owner
    SuggestionMailer.with(suggestion: self).suggestion_email.deliver_later
  end
end
