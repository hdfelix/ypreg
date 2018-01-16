require 'rails_helper'

describe Locality, type: :model do
  describe 'Associations' do
    it { should have_many :users }
    it { should have_many :lodgings }
    it { should belong_to :contact }
    it { should belong_to :lodging_contact }
  end

  describe 'Validations' do
    it { should validate_presence_of :city }
    it { should validate_presence_of :state_abbrv }
  end

  describe 'Scopes' do
    describe '#localities_not_participating_in_event' do
      it 'returns the number of localities not registered for @event in alphabetical order' do
        Locality.delete_all
        loc1 = FactoryBot.create(:locality)
        loc2 = FactoryBot.create(:locality)
        sorted_loc_array = [loc1, loc2].sort { |a, b| a.city <=> b.city }
        ev = FactoryBot.create(:event_with_registrations)

        actual = Locality.localities_not_participating_in_event(ev).map(&:city)
        expected = sorted_loc_array.map(&:city)
        expect(actual).to eq expected
      end
    end
  end

  describe 'Interface' do
    describe '#contact_name' do
      it "returns the locality's contact name" do
        locality = create(:locality, contact: create(:user, name: 'Bob'))
        expect(locality.contact_name).to eq(locality.contact.name)
      end

      it "returns '--' if locality has no contact" do
        locality = create(:locality)
        expect(locality.contact_name).to eq('--')
      end
    end

    describe '#contact_with_email' do
      it 'returns the name and e-mail of the locality contact' do
        locality = create(:locality, contact: create(:user))
        info = locality.contact.name + " (#{locality.contact.email})"
        expect(locality.contact_with_email)
          .to eq(info)
      end

      it "return '--' if locality has no contact" do
        locality = create(:locality)
        expect(locality.contact_with_email).to eq('--')
      end
    end

    describe '#contact_with_email_and_cell' do
      it 'returns the name, e-mail, and cell of the locality contact' do
        locality = create(:locality, contact: create(:user, cell_phone: '8888888888'))
        c = locality.contact
        contact_string = "#{c.name} (#{c.email}, (888) 888-8888)"
        expect(locality.contact_with_email_and_cell)
          .to eq(contact_string)
      end

      it "return '--' if locality has no contact" do
        locality = create(:locality)
        expect(locality.contact_with_email).to eq('--')
      end
    end

    describe '#hospitalities' do
      it 'returns the number of hospitalities assigned to locality' do
        ev = create(:event)
        lodging = create(:lodging)
        loc = create(:locality)
        hosp = create(:hospitality, event: ev, lodging: lodging, locality: loc)

        expect(hosp).to eq loc.hospitalities(ev).first
      end
    end

    describe '#hospitalities_min' do
      it 'returns the sum of the min capacities of all event hospitalities' do
        ev = create(:event)
        lodge1 = create(:lodging, min_capacity: 1, max_capacity: 2)
        lodge2 = create(:lodging, min_capacity: 1, max_capacity: 2)
        loc = create(:locality)
        create(:hospitality, event: ev, lodging: lodge1, locality: loc)
        create(:hospitality, event: ev, lodging: lodge2, locality: loc)
        expect(loc.hospitalities_min(ev)).to eq 2
      end
    end
    describe '#hospitalities_max' do
      it 'returns the sum of the max capacities of all event hospitalities' do
        ev = create(:event)
        lodge1 = create(:lodging, min_capacity: 1, max_capacity: 2)
        lodge2 = create(:lodging, min_capacity: 1, max_capacity: 2)
        loc = create(:locality)
        create(:hospitality, event: ev, lodging: lodge1, locality: loc)
        create(:hospitality, event: ev, lodging: lodge2, locality: loc)
        expect(loc.hospitalities_max(ev)).to eq 4
      end
    end

    describe '#assigned_beds_total' do
      it 'returns the number of beds allocated to a locality for an event that have been assigned to a registrant' do
        ev = create(:event)
        lodge1 = create(:lodging, min_capacity: 1, max_capacity: 2)
        lodge2 = create(:lodging, min_capacity: 1, max_capacity: 2)
        locality = create(:locality)
        hosp = create(:hospitality, event: ev, lodging: lodge1, locality: locality)
        create(:hospitality, event: ev, lodging: lodge2, locality: locality)

        expect(locality.assigned_beds_total(ev)).to eq 0

        user = create(:user)
        reg = create(:registration, user: user, event: ev, locality: locality)

        # Assign a registration to oru hospitality object
        hosp.update_attributes(registration: reg)

        expect(locality.assigned_beds_total(ev)).to eq 1
      end
    end

    describe '#beds_to_assign' do
      it 'returns the number of users still needing a hospitality assignment' do
        ev = create(:event)
        lodge1 = create(:lodging, min_capacity: 1, max_capacity: 2)
        lodge2 = create(:lodging, min_capacity: 1, max_capacity: 2)
        locality = create(:locality)
        hosp = create(:hospitality, event: ev, lodging: lodge1, locality: locality)
        create(:hospitality, event: ev, lodging: lodge2, locality: locality)

        user = create(:user)
        user2 = create(:user)
        reg = create(:registration, user: user, event: ev, locality: locality)
        create(:registration, user: user2, event: ev, locality: locality)
        hosp.update_attributes(registration: reg)

        expect(locality.beds_to_assign(ev)).to eq 1
      end
    end

    describe '#registrations' do
      it 'returns registrations from this locality for a given event' do
        ev   = create(:event)
        loc  = create(:locality)
        user = create(:user, locality: loc)
        reg  = create(:registration, event: ev, locality: loc, user: user)

        expect(loc.registrations(ev)).to eq([reg])
      end
    end

    describe '#registrations' do
      it 'returns the number of registrations to an event' do
        ev = create(:event)
        user = create(:user)
        locality = create(:locality)
        reg = create(:registration, user: user, event: ev, locality: locality)

        expect(locality.registrations(ev)).to eq [reg]
      end
    end

    describe '#registered_users' do
      it 'returns the number of registered users for an event' do
        ev = create(:event)
        user = create(:user)
        locality = create(:locality)
        create(:registration, user: user, event: ev, locality: locality)

        expect(locality.registered_users(ev)).to eq [user]
      end
    end

    describe '#registered_yp' do
      it 'returns all yp registered for this event' do
        ev   = create(:event)
        loc  = create(:locality)
        user = create(:user, locality: loc, role: 'yp')
        create(:registration, event: ev, locality: loc, user: user)

        expect(loc.registered_yp(ev).map(&:name)).to eq([user.name])
      end
    end

    describe '#registered_serving_ones' do
      it 'returns all serving ones registered for this event' do
        ev   = create(:event)
        loc  = create(:locality)
        user = create(:user, locality: loc)
        create(:registration,
               event: ev,
               locality: loc,
               user: user,
               attend_as_serving_one: true)

        expect(loc.registered_serving_ones(ev).map(&:name)).to eq([user.name])
      end
    end

    describe '#registered_helpers' do
      it 'retunrs all helpers registered for this event' do
        ev   = create(:event)
        loc  = create(:locality)
        user = create(:user, locality: loc, role: 'helper')
        create(:registration, event: ev, locality: loc, user: user)

        expect(loc.registered_helpers(ev).map(&:name)).to eq([user.name])
      end
    end

    describe '#registered_trainees' do
      it 'retunrs all trainees registered for this event' do
        ev   = create(:event)
        loc  = create(:locality)
        user = create(:user, locality: loc, role: 'trainee')
        create(:registration, event: ev, locality: loc, user: user)

        expect(loc.registered_trainees(ev).map(&:name)).to eq([user.name])
      end
    end

    describe '#users_not_registered' do
      it 'returns the number of users not registered to an event' do
        ev   = create(:event)
        locality  = create(:locality)
        user = create(:user, locality: locality)
        user2 = create(:user, locality: locality)
        create(:registration, event: ev, locality: locality, user: user)

        expect(locality.users_not_registered(ev)).to eq [user2]
      end
    end
  end
end
