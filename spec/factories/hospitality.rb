# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  min_cap = rand(1..3)
  max_cap = min_cap + rand(1..3)
  
  factory :hospitality do
    name { Faker::Name.last_name }
    description { Faker::Lorem.sentence } 
    address1 { Faker::Address.street_address } #generate(:address1) }
    address2 ''
    city { Faker::Address.city }
    state_abbrv  'CA' #{ Faker::Address.state_abbr }
    zipcode { Faker::Address.zip_code }
    hospitality_type "1"
    locality_id Locality.ids.sample
    min_capacity min_cap
    max_capacity max_cap

    after(:build) do |h|
      h.contact_person ||= FactoryGirl.build(:confirmed_user, :hospitality => h)
    end
    #association :contact_person, factory: :confirmed_user
    #h.contact_person { |cu| cu.association(:hospitality) }
  end
end
