FactoryBot.define do
  sequence :email do |n|
    "john#{n}@example.com"
  end

  factory :user do
    name { 'John Doe' }
    sequence(:username) { |n| "johndoe#{n}" }
    email
    password { 'password' }
  end

  factory :bill do
    name { 'Rent' }
    date { '10/10/2020' }
    association :user
  end

  factory :bill_notification do
    association :bill
    notification { false }
  end
end
