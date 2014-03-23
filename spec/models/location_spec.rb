require 'spec_helper'

describe Location do

	it "is valid with name, description, and address_id" do
		expect(build(:location)).to be_valid
	end

	it "is invalid without a name" do
		expect(build(:location, name: nil)).to have(1).errors_on(:name)	
	end

	it "is invalid without a description" do
		expect(Location.new(description: nil)).to have(1).errors_on(:description)
	end
	
	it "is invalid without an address_id" do
		expect(Location.new(address_id: nil)).to have(1).errors_on(:address_id)
	end

	it "does not allow two localities with the same address" do
		create(:location, address_id: '1')
		loc = build(:location, address_id: '1')

	expect(loc).to have(1).errors_on(:address_id)
	end
end	
