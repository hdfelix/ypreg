# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :registration do
    registration_date "2014-05-17 07:20:29"
    payment_type "9.99"
    has_been_paid false
    payment_adjustment "9.99"
    user nil
    event nil
  end
end
