# Read about factories at https://github.com/thoughtbot/factory_girl
require 'faker'

FactoryBot.define do
  ## User factories
  factory :user, aliases: [:contact, :locality_contact, :lodging_contact] do
    name { Faker::Name.first_name }
    email { Faker::Internet.email }
    password 'secretpassword'
    password_confirmation 'secretpassword'
    locality
    role 'yp'
    gender 'Brother'
    age '15'
    grade '10th'

    trait :with_admin_role do
      role 'admin'
    end

    trait :yp do
      role 'yp'
    end
  end

  factory :confirmed_user, parent: :user, aliases: [:contact_person] do
    after(:build) do |cu|
      cu.confirm
    end
  end

  ## Location factories
  factory :location do
    location_type { Location::TYPE.sample }
    name { Faker::Address.street_name }
    description { Faker::Lorem.sentence }
    address1 { Faker::Address.street_address }
    address2 ''
    city { Faker::Address.city }
    state_abbrv 'CA'
    zipcode { Faker::Address.zip_code }
    max_capacity '200'
  end

  ## Locality factories
  factory :locality do
    city { Faker::Address.city }
    state_abbrv 'CA'

    trait :with_3_saints do
      after(:create) do |instance|
        FactoryBot.create_list(:user, 3, locality: instance)
      end
    end
  end

  ## Lodging factories
  min_cap = rand(1..3)
  max_cap = min_cap + rand(1..3)

  factory :lodging do
    sequence(:name) { |n| "Household #{n}" }
    sequence(:description) { |n| "Description of household #{n}" }
    address1 { Faker::Address.street_address }
    address2 ''
    city { Faker::Address.city }
    state_abbrv 'CA'
    zipcode { Faker::Address.zip_code }
    lodging_type '1'
    min_capacity min_cap
    max_capacity max_cap
    locality
    contact_person { create(:confirmed_user) }

    trait :with_min_cap_of_3 do
      min_capacity 3
    end

    trait :with_max_cap_of_5 do
      max_capacity 5
    end
  end

  ## Event factories
  tmp_date = Time.now + 2.months

  factory :event do
    title { "#{Faker::Name.event_name} #{Faker::Name.event_modifier} #{Faker::Name.event_type}" }
    description 'This is the sample event description. Not much details here.'
    event_type '3'
    begin_date tmp_date
    end_date { (tmp_date + 3.days).strftime('%Y/%m/%d') }
    registration_open_date { (tmp_date - 1.month).strftime('%Y/%m/%d') }
    registration_close_date { (tmp_date - 1.month + 15.days).strftime('%Y/%m/%d') }
    registration_cost '10'
    location

    factory :event_with_registrations do
      transient do
        registrations_count 2
        ensure_unique_locality false
      end

      after(:create) do |event, evaluator|
        if evaluator.ensure_unique_locality
          locality = create(:locality)
          evaluator.registrations_count.times do
            user = create(:user, locality: locality)
            create(:registration, event: event, user: user, locality: user.locality)
          end
        else
          evaluator.registrations_count.times do
            locality = create(:locality)
            user = create(:user, locality: locality)
            create_list(:registration,
                        evaluator.registrations_count,
                        event: event,
                        user: user,
                        locality: locality)
          end
        end
      end
    end

    # YP Conference with 5 registered YP
    factory :event_yp_conference do
      transient do
        users_count 5
        lodgings_count 2
        hospitalities_count 3
      end

      after(:create) do |event|
        users = create_list(:user, 5, role: 'yp')
        users.each do |user|
          create_list(:registration, 5, event: event, user: user)
          2.times do
            create_list(:hospitality,
                        2,
                        event: event,
                        lodging: create(:lodging),
                        locality: create(:locality))
          end
        end
      end
    end

    trait :current_event do
      begin_date { Time.zone.now.to_date }
      end_date { (Time.zone.now + 2.days).to_date }
    end

    trait :with_hospitalities do
      transient do
        count 2
      end

      after(:create) do |event, evaluator|
        evaluator.count.times do
          create(:hospitality, event: event, lodging: create(:lodging))
        end
      end
    end

    trait :with_1_locality_with_3_registrations do
      after(:create) do |instance|
        loc = FactoryBot.create(:locality, :with_3_saints)
        User.where(locality_id: loc.id).each do |usr|
          FactoryBot.create(
            :registration,
            user: usr,
            event: instance)
        end
      end
    end

    trait :with_2_localities_with_3_registrations_each do
      after(:create) do |instance|
        loc1 = FactoryBot.create(:locality, :with_3_saints)
        loc2 = FactoryBot.create(:locality, :with_3_saints)
        User.where(locality_id: loc1.id).each do |usr|
          FactoryBot.create(
            :registration,
            user: usr,
            event: instance)
        end

        User.where(locality_id: loc2.id).each do |usr|
          FactoryBot.create(
            :registration,
            user: usr,
            event: instance)
        end
      end
    end
  end

  ## Registration factories
  factory :registration do
    payment_type 'cash'
    has_been_paid false
    payment_adjustment '0'
    attend_as_serving_one false
    hospitality nil
    locality { user.locality }
    has_medical_release_form false
    vehicle_seating_capacity 5
    conference_guest false
    status nil
    user
    event

    trait :serving_one do
      attend_as_serving_one true
    end

    trait :yp do
      user { create(:user, role: 'yp') }
    end

    trait :scyp do
      user { create(:user, role: 'scyp') }
    end
    trait :with_hospitality do
      hospitality
    end
  end

  factory :hospitality do
    event
    lodging
  end

  factory :hospitality_registration_assignment do
    event
    hospitality
    registration
    locality
  end
end
