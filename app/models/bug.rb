class Bug < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :description, presence: true

  after_create :notify_support

  private

  def notify_support
    BugMailer.with(bug: self).bug_email.deliver_later
  end
end
