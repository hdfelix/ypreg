require 'rails_helper'

describe Location, type: :model do

  describe 'Associations' do
    it { should have_many :events }
  end

  describe 'Validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :address1 }
    it { should validate_presence_of :city }
    # it { should validate_presence_of :state }
    it { should validate_presence_of :zipcode }
    it { should validate_uniqueness_of :name }
    it { should validate_presence_of :location_type }
  end

  describe 'Constants' do
    it { should have_constant :STATE_LIST }
    it { should have_constant :TYPE }
  end

	it "is valid with name, description, and address (has valid factory)" do
		expect(build(:location)).to be_valid
	end

	it "is valid without a description" do
    expect(build(:location, description: nil)).to be_valid
	end

	it "is invalid without a name" do
    expect(build(:location, name: nil)).to_not be_valid
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

