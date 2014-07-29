# Read about factories at https://github.com/thoughtbot/factory_girl
require 'faker'

FactoryGirl.define do
	factory :user do
		name {Faker::Name.first_name}		
		#lastname {Faker::Name.last_name}
		email {Faker::Internet.email}
		password 'secretpassword'
		password_confirmation 'secretpassword'
	end

#  factory :confirmed_user, parent: :user, aliases: [:contact_person] do
  factory :confirmed_user, parent: :user, aliases: [:contact_person] do
    after(:build) do |cu|
      cu.confirm!
      cu.hospitality ||= FactoryGirl.build(:hospitality, :contact_person => cu)
    end
  end
end
