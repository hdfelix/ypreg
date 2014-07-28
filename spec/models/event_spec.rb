require 'rails_helper'

describe Event, :type => :model do
	it "has a valid factory" do
		expect(build(:event)).to be_valid
	end

	it "is valid with all attributes" do
		#loc = create(:location)
		event = create(:event)
		#event = Event.new(
		#	title: '6th Grade Conference',
		#	event_type: 'Conference',
		#	begin_date: '03/01/2020',
		#	end_date: '03/03/2020',
		#	registration_cost: '10',
		#	registration_open_date: '08/01/2019',
		#	registration_close_date: '11/30/2019',
		#	location: location
		#)
		expect(event).to be_valid
	end

	it "is invalid without a title" do
		expect(Event.new(title: nil)).to have(1).errors_on(:title)
	end

	# We may want to allow the creation of events w/o a begin date
	#(so team can create the event before the date details are finalized)
	it "is invalid without a begin_date" do
		event = Event.new(
			title: 'New Event',
			end_date: '03/01/2014')
		expect(event).to have(1).errors_on(:begin_date)
	end
	
	# We may want to allow the creation of events w/o a end  date
	#(so team can create the event before the date details are finalized)
	it "is invalid without an end_date" do
		event = Event.new(
			title: 'Test Event',
			begin_date: '01/01/2020')
		expect(event).to have(1).errors_on(:end_date)
	end
	
	it "is invalid without the cost of attendance" do
		expect(Event.new(registration_cost: nil)).to have(1).errors_on(:registration_cost)
	end
end
