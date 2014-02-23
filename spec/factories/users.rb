#spec/factories/users.rb
require 'faker'
FactoryGirl.define do
	factory :user do
		firstname {Faker::Name.first_name}		
		lastname {Faker::Name.last_name}
		email {Faker::Internet.email}
		#password '123'
		#password_confirmation '123'
	end
end

