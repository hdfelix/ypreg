require 'spec_helper'

describe Address do
	it "has a valid factory" do
		expect(build(:address)).to be_valid
	end

	it "is valid with addressline1, city, zicode, state_id" do
		address = Address.new(
			addressline1: '100 Street',
			city: 'City',
			state_id:  '3',
			zipcode: '92612'
		)
		expect(address).to be_valid
	end

	it "is invalid without addressline1" do
		expect(build(:address, addressline1: nil)).to be_invalid
	end

	it "is invalid without a city" do
		expect(build(:address, city: nil)).to be_invalid
	end

	it "is invalid without a state" do
		expect(build(:address, state_id: nil)).to be_invalid
	end

	it "is invalid without a zipcode" do
		expect(build(:address, zipcode: nil)).to be_invalid
	end
end
