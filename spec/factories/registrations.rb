# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :registration do
    registration_date "2014-05-17"
    payment_type "5"
    has_been_paid false
    payment_adjustment "5"
    user nil
    event nil
  end
end
