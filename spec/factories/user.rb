FactoryBot.define do
  factory :user do
    name { 'John Doe' }
    username { 'johndoe' }
    email { 'john@gmail.com' }
    password { 'password' }
  end
end
