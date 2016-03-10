FactoryGirl.define do
  factory :user do
    name "Test User"

    trait :admin do
      role 'admin'
    end
  end
end
