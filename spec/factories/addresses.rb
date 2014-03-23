# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
	sequence(:addressline1, 100) {|a| "#{n} Street #{a-95}" }
	sequence(:city) {|c| "City#{n}" }
	sequence(:zipcode, 92610) {|z| "#{n}" }
	#sequence(:state_id, 1..49)
  
	factory :address do
		addressline1
		city
		state_id '1'
		zipcode
  end
end
