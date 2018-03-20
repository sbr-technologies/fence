FactoryGirl.define do
  factory :manufacturer do
    sequence(:number) { |n| rand(1000) }
    sequence(:name) { |n| "manufacturer-#{rand(1000)}" }
    start_date Date.today.to_s
    end_date Date.tomorrow.to_s
    end_reason 'MyText'
    association :organization
  end
end
