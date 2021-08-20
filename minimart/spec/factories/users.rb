FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "tomart#{n}" }
    pickup_location
  end
end
