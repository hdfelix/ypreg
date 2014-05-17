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
end
