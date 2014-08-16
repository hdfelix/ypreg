# Read about factories at https://github.com/thoughtbot/factory_girl
require 'faker'

FactoryGirl.define do

  ## User factories
	factory :user do
		name {Faker::Name.first_name}		
		#lastname {Faker::Name.last_name}
		email {Faker::Internet.email}
		password 'secretpassword'
		password_confirmation 'secretpassword'

    trait :admin do
      role 'admin'
    end

    factory :admin, traits: [:admin]
  end	

  factory :confirmed_user, parent: :user, aliases: [:contact_person, :lodging_contact] do
    after(:build) do |cu|
      cu.confirm!
      #cu.lodging ||= FactoryGirl.build(:lodging, :contact_person => cu)
    end
  end

  ## Location factories

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
    max_capacity '200'
  end
	
	factory :invalid_location, parent: :location  do
		name nil
		address1 nil
		city nil
		state_abbrv nil
		zipcode nil
	end

  ## Locality factories
  factory :locality do
		city { Faker::Address.city }
		state_abbrv  'CA' #{ Faker::Address.state_abbr }
    lodging_contact_id '1' # { lodging_contact }
  end

  ## Lodging factories
  min_cap = rand(1..3)
  max_cap = min_cap + rand(1..3)
  
  factory :lodging do
    # before(:build) do
    #   FactoryGirl.create(:confirmed_user, id:100)
    # end

    name 'bob' #{ Faker::Name.last_name }
    description { Faker::Lorem.sentence } 
    address1 { Faker::Address.street_address } #generate(:address1) }
    address2 ''
    city { Faker::Address.city }
    state_abbrv  'CA' #{ Faker::Address.state_abbr }
    zipcode { Faker::Address.zip_code }
    lodging_type "1"
    min_capacity min_cap
    max_capacity max_cap

    after(:build) do |lodging|
      lodging.contact_person ||= FactoryGirl.build(:confirmed_user)
      lodging.locality ||= FactoryGirl.build(:locality)
    end


    #factory(:lodging_with) do
    #contact_person {[FactoryGirl.create(:confirmed_user), ]}
    #contact_person_id 100
  #end

    # after(:build) do |h|
    #   h.contact_person ||= FactoryGirl.build(:confirmed_user, :lodging => h)
    # end
    #association :contact_person, factory: :confirmed_user
    #h.contact_person { |cu| cu.association(:lodging) }
  end
 
  ## Event factories
	sequence(:title) {|n| "Sample Event #{n}" }
  tmp_date = Time.now + 2.months

  factory :event do
    title { generate(:title) }
		event_type '3'  #
    begin_date tmp_date 
    end_date (tmp_date + 3.days).strftime('%Y/%m/%d') 
    registration_open_date (tmp_date - 1.month).strftime('%Y/%m/%d') 
    registration_close_date (tmp_date - 1.month + 15.days).strftime('%Y/%m/%d') 
		registration_cost '10'
		location
  end

  ## Registration factories
  factory :registration do
    payment_type "5"
    has_been_paid false
    payment_adjustment "5"
    user nil
    event nil
  end
end
