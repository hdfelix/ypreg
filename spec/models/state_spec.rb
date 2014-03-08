require 'spec_helper'

describe State do
	it "has a valid factory" do
		expect(build(:state)).to be_valid
	end

	it "is invalid without a state name" do
		expect(build(:state, name: nil)).to be_invalid
	end

	it "is invalid without a state abbreviation" do
		expect(build(:state, abbrv: nil)).to be_invalid
	end

	it "is invalid with a duplicate name" do
		create(:state, name: "California")
		st = build(:state, name: "California")
		expect(st).to have(1).errors_on(:name)
	end

	it "is invalid with a duplicate abbreviation" do
		create(:state, abbrv: "CA")
		st = build(:state, abbrv: "CA")
		expect(st).to have(1).errors_on(:abbrv)
	end

end
