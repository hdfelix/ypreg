# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
	#city_array = ['This City', 'That City', 'Other City', 'City', 'Far City']
	#sate_array = ['CT', 'CA']
	
	sequence(:name) { |n| 'Sample Location #{n}' }
	sequence(:description) { |n| 'This is an example description for location #{n}' }
	sequence(:address1) { |n| '#{n} Sample St'}
	#sequence(:city,  {|n| city_array(n)}
  #sequence(:state, {|n| state_array(1%n)}
	
  factory :location do
    name
		description
		address1
		city 'Test City'
		#state 'CT'
		zipcode '92612'
  end
	
	factory :invalid_location do
		name nil
		address1 nil
		city nil
		#state nil
		zicode nil
	end
end
