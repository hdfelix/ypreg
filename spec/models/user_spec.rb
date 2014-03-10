#spec/models/user_spec.rb
require 'spec_helper'

describe User do
	it "has a valid factory" do
		expect(build(:user)).to be_valid
	end

	it "is valid with a firstname, lastname, and email" do
		user = User.new(
			firstname: 'Hector',
			lastname: 'Felix',
			email: 'test@gmial.com')
		expect(user).to be_valid
	end

	it "is invalid without a firstname" do
		expect(User.new(firstname: nil)).to have(1).errors_on(:firstname)
	end

	it "is invalid without a lastname" do
		expect(User.new(lastname: nil)).to have(1).errors_on(:lastname)
	end

	it "is invalid without an e-mail" do
		expect(build(:user, email: nil)).should_not be_valid
	end
	
	it "is invalid with a duplicate email address" do
		User.create(firstname: 'Hector', 
								lastname: 'Felix',
								email: 'test@gmail.com')
		user = User.create(firstname: 'Angela',
								lastname: 'Felix',
								email: 'test@gmail.com')
		expect(user).to have(1).errors_on(:email)
	end

	# it "returns an user's full name as a string"
end
