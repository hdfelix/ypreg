require 'rails_helper'

describe EventLocality, type: :model do
  describe 'Associations' do
    it { should belong_to :event }
    it { should belong_to :locality }
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

        expect(EventLocality.registrations(event, loc).count).to eq 2
      end
    end

    describe '#beds_assigned_to_locality'
    describe '#beds_assignd_to_a_saint'
  end
end
