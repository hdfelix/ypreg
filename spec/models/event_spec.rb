require 'rails_helper'

describe Event, :type => :model do

  describe Event, "Associations" do
    it { should belong_to :location }
    it { should have_many :registrations }
    it { should have_many :users }
    it { should have_many :localities }
    it { should have_many :hospitalities }
    # it { should have_many :lodgings }
    it { should have_many :hospitality_assignments }
  end

  describe Event, "Validations" do
    it { should validate_presence_of :event_type }
    it { should validate_presence_of :title }
    it { should validate_presence_of :begin_date }
    it { should validate_presence_of :end_date }
    it { should validate_presence_of :registration_cost }
    it { should validate_presence_of :location_id }
    it { should have_constant :EVENT_TYPE }
  end

  describe Event, "Scopes" do
    describe "#remaining_spaces" do
      it "returns the max capacity of spaces when there are no registrations" do 
        event = build_stubbed(:event)

        expect(event.remaining_spaces).to eq (event.location.max_capacity)
      end

      it "returns the remaining number of available registrations" do
        loc = build_stubbed(:location, max_capacity: 20)
        event = create(:event_with_registrations, registrations_count: 3, location: loc)

        expect(event.remaining_spaces).to eq (17)
      end
    end
  end

  # describe "#participating_localities" do
  #   event = create(:event_with_registrations)
  # end

  describe "#registered_saints_per_locality" do
    # it "returns a hash with registered users per locality" do
    #   localities = FactoryGirl.create_list(:locality, 3)
    #   users = FactoryGirl.create_list(:user, 3, locality_id: localities[1].id)
    #   users << FactoryGirl.create_list(:user, 2, locality_id: localities[2].id)
    #   users << FactoryGirl.create_list(:user, 4, loclity_id: localities[4].id)

    #   # expect  
    # end
  end
end
