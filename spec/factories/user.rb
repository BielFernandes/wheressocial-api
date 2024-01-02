FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'bieldias882' }
    name { Faker::Name.name }
    nickname { Faker::Alphanumeric.alpha(number: 10) }
  end
end