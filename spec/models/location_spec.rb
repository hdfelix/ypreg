require 'rails_helper'

describe Location, :type => :model do

	it "is valid with name, description, and address (has valid factory)" do
		expect(build(:location)).to be_valid
	end

	it "is invalid without a name" do
    expect(build(:location, name: nil)).to_not be_valid
	end

	it "is invalid without a description" do
    expect(build(:location, description: nil)).to_not be_valid
	end
	
	it "is invalid without an address1 line" do
    expect(build(:location, address1: nil)).to_not be_valid
	end

	it "does not allow two localities with the same address"
end	
