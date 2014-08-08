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

  # Add an index to make this test pass; validators work on attributes, not on entries (objects)
	#it "does not allow two locations with the same address" do
  #  create(:location,
  #                   address1: '100 Street',
  #                   city: 'Town',
  #                   state_abbrv: 'FT',
  #                   zipcode: '00000')
  #  expect(build(:location,
  #               address1: '100 Street',
  #               city: 'Town',
  #               state_abbrv: 'FT',
  #               zipcode: '00000')
  #        ).to_not be_valid
  #end
end	

