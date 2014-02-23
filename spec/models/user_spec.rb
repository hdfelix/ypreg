#spec/models/user_spec.rb
require 'spec_helper'

describe User do
	it "has a valid factory" do
		build(:user).should be_valid
	end
	it "is valid with a firstname, lastname, and email" do
		user = User.new(
			firstname: 'Hector',
			lastname: 'Felix',
			email: 'test@gmial.com')
		expect(user).to be_valid
	end

	it "is invalid without a firstname"
	it "is invalid without a lastname"
	it "is invalid without an e-mail" do
		build(:user, email: nil).should_not be_valid
	end
	it "is invalid with a duplicate email address"
	it "returns an user's full name as a string"
end
