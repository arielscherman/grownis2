FactoryBot.define do
  factory :depot do
    sequence(:name) { |n| "depot-#{n}" }
    user
    currency
  end
end
