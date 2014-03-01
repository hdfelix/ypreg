require 'spec_helper'

describe Location do
	it "has a valid factory" do
		expect(build(:location)).to be_valid
	end

	it "is valid with name, description, and address_id" do
		location = Location.new(
			name: 'Test Location',
			description: 'This location does not exist.',
			address_id: '1')
		expect(location).to be_valid
	end

	it "is invalid without a name" do
		expect(Location.new(name: nil)).to have(1).errors_on(:name)	
	end

	it "is invalid without a description" do
		expect(Location.new(description: nil)).to have(1).errors_on(:description)
	end
	

	it "is invalid without an address_id" do
		expect(Location.new(address_id: nil)).to have(1).errors_on(:address_id)
	end
	
end
