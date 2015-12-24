FactoryGirl.define do
  sequence :email do |n|
    "user_#{n}@test.com"
  end

  factory :user do
    name "Fred Flinstone"
    email
  end
end
