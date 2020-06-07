FactoryBot.define do
  factory :currency do
    sequence(:name)   { |n| "currency-#{n}" }
    sequence(:symbol) { |n| "CU-#{n}" }
    
    trait :usd do
      name   { "US Dollars" }
      symbol { "USD" }
    end
  end
end
