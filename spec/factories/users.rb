FactoryBot.define do
  factory :user do
    sequence(:username) { |n| "Username##{n}" }
    sequence(:email)    { |n| "user#{n}@gmail.com" }
    password            { "secret_password" }
  end
end
