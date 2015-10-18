require 'rails_helper'

describe EventLocality, type: :model do
  describe 'Associations' do
    it { should belong_to :event }
    it { should belong_to :locality }
  end

  describe 'Class Methods' do
    describe '.registrations' do
      it 'return the registrations for an event' do
        ev = create(:event)
        loc = create(:locality)
        user = create(:user, locality: loc)
        user2 = create(:user, locality: loc)
        reg = create(:registration, event: ev, user: user)
        reg2 = create(:registration, event: ev, user: user2)

        expect(EventLocality.registrations(ev, loc)).to contain_exactly(reg, reg2)
      end
    end
  end

  describe 'Instance Methods' do
    let(:event) { create(:event) }
    let(:loc) { create(:locality) }
    let(:el) { EventLocality.create(event: event, locality: loc) }

    describe '#locality_id' do
      it 'returns the locality id' do
        expect(el.locality.id).to eq (el.locality_id)
      end

      it 'should not be nil' do
        expect(el).not_to be_nil
      end
    end

    describe '#locality_city' do
      it 'returns the locality city' do
        expect(el.locality.city).to eq (el.locality_city)
      end

      it 'does not return nil' do
        expect(el.locality_city).not_to be_nil
      end
    end

    describe '#users' do
      it 'returns users from a locality registered for an event' do
        usr1  = create(:user, locality: loc)
        usr2  = create(:user, locality: loc)

        create(:registration, event: event, user: usr1)
        create(:registration, event: event, user: usr2)

        event_locality = EventLocality.find_by_locality_id(loc.id)

        expect(event_locality.users.count).to eq 2
      end
    end

    describe '#registrations' do
      it 'returns registrations from a locality for an event' do
        usr1  = create(:user, locality: loc)
        usr2  = create(:user, locality: loc)
        create(:registration, event: event, user: usr1)
        create(:registration, event: event, user: usr2)
        event_locality = EventLocality.find_by_locality_id(loc.id)

        expect(event_locality.registrations.count).to eq 2
      end
    end

    describe '#paid_registrations' do
      it 'returns registrations from a locality for an event' do
        usr1  = create(:user, locality: loc)
        usr2  = create(:user, locality: loc)
        create(:registration, event: event, user: usr1)
        create(:registration, event: event, user: usr2, has_been_paid: true)
        event_locality = EventLocality.find_by_locality_id(loc.id)

        expect(event_locality.paid_registrations.count).to eq 1
      end
    end

    describe '#beds_assigned_to_locality' do
      it 'returns the number of beds assigned to a locality' do
        event = create(:event_with_registrations, ensure_unique_locality: true)
        reg = Registration.where(event: event).first
        locality = reg.locality
        lodge = create(:lodging, locality: locality, min_capacity: 3)
        create(:hospitality, event: event, lodging: lodge, registration: reg, locality: locality)

        el = EventLocality.where(event: event, locality: locality).first
        expect(el.beds_assigned_to_locality).to eq lodge.min_capacity
      end

      it 'returns 0 when no beds ared assigned to a locality' do
        ev = create(:event_with_registrations)
        el = EventLocality.where(event: ev).first

        expect(el.beds_assigned_to_locality).to eq 0
      end
    end

    describe '#number_of_beds_assignd_to_registrations' do
      it 'returns the number of hospitality beds that have been assigned \
      to users attending an event' do
        event = create(:event_with_registrations, ensure_unique_locality: true)
        reg = Registration.where(event: event).first
        locality = reg.locality
        lodge = create(:lodging, locality: locality, min_capacity: 3)
        create(:hospitality,
               event: event,
               lodging: lodge,
               registration: reg,
               locality: locality)

        el = EventLocality.where(event: event, locality: locality).first
        expect(el.number_of_beds_assigned_to_registrations).to eq 1
      end
    end
  end
end
