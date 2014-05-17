require 'spec_helper'

describe Location do

	it "is valid with name, description, and address (has valid factory)" do
		expect(build(:location)).to be_valid
	end

	it "is invalid without a name" do
		expect(build(:location, name: nil)).to have(1).errors_on(:name)	
	end

	it "is invalid without a description" do
		expect(Location.new(description: nil)).to have(1).errors_on(:description)
	end
	
	it "is invalid without an address1 line" do
		expect(Location.new(address1: nil)).to have(1).errors_on(:address1)
	end

	it "does not allow two localities with the same address"
end	
