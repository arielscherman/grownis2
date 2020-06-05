require "rails_helper"

RSpec.describe Depot, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:currency) }
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:movements) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
  end
  
  describe "delegates" do
    it { is_expected.to delegate_method(:symbol).to(:currency).with_prefix }
  end
end
