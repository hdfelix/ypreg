
# Read about factories at https://github.com/thoughtbot/factory_girl
require 'faker'

FactoryGirl.define do

  # factory :address do
  # end

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

    trait :yp do
      role 'yp'
    end

    factory :admin, traits: [:admin]
    factory :contact, class: :user
    factory :locality_contact, class: :user # TODO: needed?
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

  ## Locality factories
  factory :locality do
		city { Faker::Address.city }
		state_abbrv  'CA' #{ Faker::Address.state_abbr }
    # lodging_contact
    
    trait :with_3_saints do
      after(:create) do |instance|
        FactoryGirl.create_list(:user, 3, locality: instance)
      end
    end
  end

  ## Lodging factories
  min_cap = rand(1..3)
  max_cap = min_cap + rand(1..3)

  factory :lodging do
    sequence(:name) { |n| "Household #{n}" }
    description "Description for #{:name}"
    address1 { Faker::Address.street_address } #generate(:address1) }
    address2 ''
    city { Faker::Address.city }
    state_abbrv  'CA' 
    zipcode { Faker::Address.zip_code }
    lodging_type "1"
    min_capacity min_cap
    max_capacity max_cap
    locality
    contact_person { create(:confirmed_user) }
  end
 
  ## Event factories
	sequence(:title) {|n| "Sample Event #{n}" }
  tmp_date = Time.now + 2.months

  factory :event do
    title { generate(:title) }
    description "This is the sample event description. Not much details here."
		event_type '3'  #
    begin_date tmp_date 
    end_date (tmp_date + 3.days).strftime('%Y/%m/%d') 
    registration_open_date (tmp_date - 1.month).strftime('%Y/%m/%d') 
    registration_close_date (tmp_date - 1.month + 15.days).strftime('%Y/%m/%d') 
		registration_cost '10'
		location

    factory :event_with_registrations do
      ignore do
        registrations_count 3
      end

      after(:create) do |event, evaluator|
        create_list(:registration, evaluator.registrations_count, event: event)
      end
    end

    factory :event_yp_conference do
      ignore do
        users_count 5
        lodgings_count 2
        hospitalities_count 3
      end

      after(:create) do |event, evaluator|
        users = create_list(:user, 5, role: 'yp')
        create_list(:lodging, 2)
        users.each do |user|
          create_list(:registration, 5, event: event, user: user)
          create(:hospitality, event: event, lodging: Lodging.find(1), locality: create(:locality))
          create(:hospitality, event: event, lodging: Lodging.find(2), locality: create(:locality))
        end

        Registration.find(1..3) do |registration|
          create(:hospitality_assignment, hospitality: Hospitality.find(1), registration: registration)
        end

        Registration.find(4..5) do |registration|
          create(:hospitality_assignment, hospitality: Hospitality.find(2), registration: registration)
        end
      end
    end

    trait :with_1_locality_with_3_registrations do
      after(:create) do |instance|
        loc = FactoryGirl.create(:locality, :with_3_saints)
        User.where(locality_id: loc.id).each do |usr|
          FactoryGirl.create(
            :registration,
            user_id: usr.id,
            event_id: instance.id)
        end
      end
    end

    trait :with_2_localities_with_3_registrations_each do
      after(:create) do |instance|
        loc1 = FactoryGirl.create(:locality, :with_3_saints)
        loc2 = FactoryGirl.create(:locality, :with_3_saints)
        User.where(locality_id: loc1.id).each do |usr|
          FactoryGirl.create(
            :registration,
            user_id: usr.id,
            event_id: instance.id)
        end

        User.where(locality_id: loc2.id).each do |usr|
          FactoryGirl.create(
            :registration,
            user_id: usr.id,
            event_id: instance.id)
        end
      end
    end
  end

  ## Registration factories
  factory :registration do
    payment_type "Cash"
    has_been_paid false
    payment_adjustment "5"
    attend_as_serving_one false
    user 
    event

    trait :serving_one do
      attend_as_serving_one true
    end

    trait :with_hospitality do
      hospitality
    end
  end

  factory :hospitality do
    event
    lodging
    locality
  end

  factory :hospitality_assignment do
    hospitality
    registration
  end
end
