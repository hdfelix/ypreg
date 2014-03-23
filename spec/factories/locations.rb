# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
	sequence(:name) { |n| "Sample Location #{n}" }
	sequence(:description) { |n| "This is an example description for location #{n}" }
	sequence(:address_id) { |n| '#{n}'}
  factory :location do
    name
		description
		address_id
  end
	
	factory :invalid_location do
		name nil
		address nil
	end
end
