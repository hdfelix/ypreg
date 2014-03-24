# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
	sequence(:addressline1, 100) {|n| "#{n} Street #{n-95}" }
	sequence(:city) {|c| "City#{c}" }
	sequence(:zipcode, 92612) {|z| "#{z}" }
	#sequence(:state_id, 1..49)
  
	factory :address do
		addressline1
		city
		state_id '1'
		zipcode
  end
end
