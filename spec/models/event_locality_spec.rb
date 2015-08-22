require 'rails_helper'

describe EventLocality, type: :model do
  describe 'Associations' do
    it { should belong_to :event }
    it { should belong_to :locality }
  end

  describe '#users' do
    it 'returns users from a locality registered for an event' do
      event = create(:event)
      loc   = create(:locality)
      usr1  = create(:user, locality: loc)
      usr2  = create(:user, locality: loc)

      create(:registration, event: event, user: usr1)
      create(:registration, event: event, user: usr2)

      event_locality = EventLocality.find_by_locality_id(loc.id)

      expect(event_locality.users.count).to eq 2
    end
  end
	
  describe '#registrations' do
    it 'returns registrations from a locality for a perticular event' do
      event	= create(:event) 
      loc   = create(:locality)
      usr1  = create(:user, locality: loc)
      usr2  = create(:user, locality: loc)

      create(:registration, event: event, user: usr1)
      create(:registration, event: event, user: usr2)

			expect(EventLocality.registrations(event, loc).count).to eq 2
    end
  end
end
