# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :user do
    username { Faker::Internet.username }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end
end

FactoryBot.define do
  factory :article do
    user
    title { Faker::Name.first_name }
    text { Faker::Name.last_name }
  end
end
