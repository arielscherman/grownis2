FactoryBot.define do
  factory :rate_value, class: 'Rate::Value' do
    currency { nil }
    rate { nil }
    value { "" }
  end
end
