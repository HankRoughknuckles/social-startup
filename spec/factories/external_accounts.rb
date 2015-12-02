FactoryGirl.define do
  factory :external_account do
    hostsite "Facebook"
    url "http://www.facebook.com/someuser"
    user nil
  end
end
