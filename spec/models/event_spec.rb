require 'rails_helper'

describe Event, :type => :model do
	it "has a valid factory" do expect(build(:event)).to be_valid
	end

	it "is valid with all attributes" do
		event = create(:event)
		expect(event).to be_valid
	end

	it "is invalid without a title" do
    expect(build(:event, title:nil)).to_not be_valid
	end

	# We may want to allow the creation of events w/o a begin date
	#(so team can create the event before the date details are finalized)
	it "is invalid without a begin_date" do
    expect(build(:event, begin_date: nil)).to_not be_valid
	end
	
	# We may want to allow the creation of events w/o a end  date
	#(so team can create the event before the date details are finalized)
	it "is invalid without an end_date" do
    expect(build(:event, end_date: nil)).to_not be_valid
	end
	
	it "is invalid without the cost of attendance" do
    expect(build(:event, registration_cost: nil)).to_not be_valid
	end
end
