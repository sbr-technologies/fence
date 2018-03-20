FactoryGirl.define do
  factory :supplier do |s|
    sequence(:name) { |n| "supplier #{rand(1000)}" }
    s.addresses { |a| [a.association(:address)] }
    start_date Date.today.to_s
    end_date Date.tomorrow.to_s
    end_reason 'MyText'
    association :organization
  end
end
