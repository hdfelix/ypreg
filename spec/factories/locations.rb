# Read about factories at https://github.com/thoughtbot/factory_girl
FactoryGirl.define do
	#city_array = ['This City', 'That City', 'Other City', 'City', 'Far City']
	#sate_array = ['CT', 'CA']
	
	#sequence(:name) { |n| "Sample Location #{n}" }
	#sequence(:description) { |n| "This is an example description for location #{n}" }
	#sequence(:address1) { |n| "#{n} Sample St" }
	
  factory :location do
		name { Faker::Address.street_name } #{ generate(:name) }
		description { Faker::Lorem.sentence } #generate(:description) }
		address1 { Faker::Address.street_address } #generate(:address1) }
		address2 ''
		city { Faker::Address.city }
		state_abbrv  'CA' #{ Faker::Address.state_abbr }
		zipcode { Faker::Address.zip_code }
  end
	
	factory :invalid_location do
		name nil
		address1 nil
		city nil
		state nil
		zicode nil
	end
end
