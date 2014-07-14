# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :localities do
		name { Faker::Address.street_name } #{ generate(:name) }
		description { Faker::Lorem.sentence } #generate(:description) }
		address1 { Faker::Address.street_address } #generate(:address1) }
		address2 ''
		city { Faker::Address.city }
		state_abbrv  'CA' #{ Faker::Address.state_abbr }
		zipcode { Faker::Address.zip_code }
  end
end
