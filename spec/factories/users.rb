FactoryGirl.define do
  factory :user do
    email Faker::Internet.email
    password 'josh123'
    password_confirmation 'josh123'
  end
end
