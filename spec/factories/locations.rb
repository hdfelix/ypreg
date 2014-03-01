# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :location do
    name "Test Location"
		description "This is a test location string"
		address_id '1'
  end
end
