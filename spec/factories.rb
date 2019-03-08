require 'faker'

FactoryBot.define do
  factory :user do
    sequence(:username) { |n| "user#{n}" }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    password { 'testtesttest' }
  end
end

FactoryBot.define do
  factory :article do
    user
    title { Faker::Name.first_name }
    text { Faker::Name.last_name }
  end
end
