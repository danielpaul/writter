require 'faker'

FactoryBot.define do
  factory :user do
    sequence(:username) { |n| "user#{n}" }
    first_name { Faker::Name.first_name }
    last_name { 'Doe' }
    email { 'johndoe@me.com' }
    password { 'testtesttest' }
  end
end
