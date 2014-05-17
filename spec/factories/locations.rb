# Read about factories at https://github.com/thoughtbot/factory_girl
FactoryGirl.define do
	#city_array = ['This City', 'That City', 'Other City', 'City', 'Far City']
	#sate_array = ['CT', 'CA']
	
	sequence(:name) { |n| "Sample Location #{n}" }
	sequence(:description) { |n| "This is an example description for location #{n}" }
	sequence(:address1) { |n| "#{n} Sample St" }
	
  factory :location do
    name #{ generate(:name) }
		description {generate(:description) }
		address1 {generate(:address1) }
		address2 ''
		city 'Test City'
		state_abbrv 'CA'
		zipcode '92612'
  end
	
	factory :invalid_location do
		name nil
		address1 nil
		city nil
		state nil
		zicode nil
	end
end
