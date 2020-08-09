class User::Message < ApplicationRecord
  REPORT_BEING_GENERATED_MESSAGE = "Los reportes se generan por las noches. Volvé mañana para ver información sobre tus billeteras.".freeze

  belongs_to :user

  scope :unread, -> { where(acknowledged: false) }

  class << self
    def on_first_depot_created!(user)
      create!(user: user, description: REPORT_BEING_GENERATED_MESSAGE)
    end
  end
end
