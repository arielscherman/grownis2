require "rails_helper"

RSpec.describe Movement, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:depot) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:date) }
    it { is_expected.to validate_presence_of(:total_cents) }
  end
end
