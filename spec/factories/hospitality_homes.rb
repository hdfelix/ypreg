# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :hospitality_home do
    name "MyString"
    home_phone "MyString"
    cell_phone "MyString"
    email "MyString"
    minimum_capacity 1
    maximum_capacity 1
    comments "MyString"
  end
end
