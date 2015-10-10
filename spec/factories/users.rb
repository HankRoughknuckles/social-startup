FactoryGirl.define do
  factory :user do
    sequence(:email)        { |n| "person#{n}@example.com" }
    password                "asdfasdf"
    password_confirmation   "asdfasdf"
    first_name              "John"
    last_name               "Doe"
  end
end
