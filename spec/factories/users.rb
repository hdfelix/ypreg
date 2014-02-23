#spec/factories/users.rb
require 'faker'
FactoryGirl.define do
	factory :user do
		email {Faker::Internet.email}
		password '123'
		password_confirmation '123'
	end
end

