FactoryBot.define do
  factory :user do
    sequence(:username) { |n| "user#{n}" }
    first_name { 'John' }
    last_name { 'Doe' }
    email { 'johndoe@me.com' }
    password { 'testtesttest' }
  end
end
