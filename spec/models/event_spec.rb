require 'rails_helper'

describe Event, type: :model do

  describe 'Associations' do
    it { should belong_to :location }
    it { should have_many :registrations }
    it { should have_many :users }
    it { should have_many :localities }
    it { should have_many :hospitalities }
    it { should have_many(:hospitality_registration_assignments).through(:hospitalities) }
  end

  describe 'Validations'do
    it { should validate_presence_of :event_type }
    it { should validate_presence_of :title }
    it { should validate_presence_of :begin_date }
    it { should validate_presence_of :end_date }
    it { should validate_presence_of :registration_cost }
    it { should validate_presence_of :location_id }
    it { should have_constant :EVENT_TYPE }
  end

  describe 'Scopes' do
    describe '#remaining_spaces' do
      it 'returns the max capacity of spaces when there are no registrations' do
        event = build_stubbed(:event)

        expect(event.remaining_spaces).to eq(event.location.max_capacity)
      end

      it 'returns the remaining number of available registrations' do
        loc = build_stubbed(:location, max_capacity: 20)
        event = create(:event_with_registrations,
                       registrations_count: 3,
                       location: loc)

        expect(event.remaining_spaces).to eq(17)
      end
    end
  end

  describe '#participating_localities' do
    it 'returns the localities participating in the event' do
      # event = create(
      #   :event_with_registrations,
      #   registrations_count: 2,
      #   ensure_unique_locality: false)
      # loc1 = event.registrations.first.user.locality
      # loc2 = event.registrations.second.user.locality
      event = create(:event)
      loc1  = create(:locality)
      loc2  = create(:locality)
      usr1  = create(:user, locality: loc1)
      usr2  = create(:user, locality: loc2)

      reg1  = create(:registration, user: usr1)
      reg2  = create(:registration, user: usr2)

      event.registrations << [reg1, reg2]

      participating_localities = event.participating_localities
      expect(participating_localities.count).to eq 2
      expect(participating_localities).to contain_exactly(loc1, loc2)
    end
  end

  describe '#registered_saints_from_locality' do
    it 'returns a hash with registered users per locality' do
      event = create(:event_with_registrations,
                     registrations_count: 2,
                     ensure_unique_locality: true)
      loc  = event.participating_localities.first
      usr1 = event.registrations.first.user
      usr2 = event.registrations.second.user

      expect(event.registered_saints_from_locality(loc)).to contain_exactly(usr1, usr2)
    end
  end

  describe '#registered_saints_per_locality'

  describe '#total_registrations' do
    # TODO test all new options {}
    it 'returns the number of registrations per locality for the given role' do
      reg   = create(:registration, :yp)
      event = reg.event
      loc   = reg.user.locality
      role  = reg.user.role

      expect(event.total_registrations(role: role, locality: loc)).to eq(1)
    end
  end

  describe '#registered_serving_ones' do
    it 'returns the number of serving ones from a locality attending the event' do
      reg   = create(:registration, :serving_one)
      event = reg.event
      loc   = reg.user.locality

      expect(event.registered_serving_ones(loc)).to eq(1)
    end
  end

  describe '#assigned_lodgings_as_hospitality' do
    it 'returns lodgings registered as hospitality for an event' do
      ev      = create(:event)
      loc     = create(:locality)
      lodge1  = create(:lodging)
      lodge2  = create(:lodging)
      create(:hospitality, event: ev, lodging: lodge1, locality: loc)
      create(:hospitality, event: ev, lodging: lodge2, locality: loc)

      expect(ev.assigned_lodgings_as_hospitality).to include(lodge1, lodge2)
    end

    it 'should not return lodgings not registered as hospitality for an event' do
      Lodging.delete_all
      Locality.delete_all
      Hospitality.delete_all
      Event.delete_all

      ev      = create(:event)
      loc     = create(:locality)
      lodge1  = create(:lodging)
      lodge2  = create(:lodging)
      lodge3  = create(:lodging)
      create(:hospitality, event: ev, lodging: lodge1, locality: loc)
      create(:hospitality, event: ev, lodging: lodge2, locality: loc)

      expect(ev.assigned_lodgings_as_hospitality).not_to eq([lodge3])
    end
  end

  describe '#unassigned_lodgings_as_hospitality' do
    it 'returns lodgings not registered as hospitality for an event' do
      Lodging.delete_all
      Locality.delete_all
      Hospitality.delete_all
      Event.delete_all

      ev      = create(:event)
      loc     = create(:locality)
      lodge1  = create(:lodging)
      lodge2  = create(:lodging)
      lodge3  = create(:lodging)
      create(:hospitality, event: ev, lodging: lodge1, locality: loc)
      create(:hospitality, event: ev, lodging: lodge2, locality: loc)

      expect(ev.unassigned_lodgings_as_hospitality).to eq([lodge3])
    end

    it 'should not return lodgings registered as hospitality for an event' do
      ev      = create(:event)
      loc     = create(:locality)
      lodge1  = create(:lodging)
      lodge2  = create(:lodging)
      create(:lodging)
      create(:hospitality, event: ev, lodging: lodge1, locality: loc)
      create(:hospitality, event: ev, lodging: lodge2, locality: loc)

      expect(ev.unassigned_lodgings_as_hospitality).not_to eq([lodge1, lodge2])
    end
  end
  describe '#assigned_hospitality_beds' do
    it 'return an empty hash if the event has no hospitalities' do
      ev = create(:event)

      expect(ev.assigned_hospitality_beds).to eq({})
    end

    it 'returns a hash - # of beds (based on min_capacity of each lodging)
        assigned to each participating locality' do
      ev      = create(:event)
      lodge1  = create(:lodging, :with_min_cap_of_3)
      lodge2  = create(:lodging, :with_min_cap_of_3)
      loc1    = create(:locality)
      loc2    = create(:locality)
      create(:hospitality, event: ev, lodging: lodge1, locality: loc1)
      create(:hospitality, event: ev, lodging: lodge2, locality: loc2)
      result = {
        "#{loc1.city}" => lodge1.min_capacity,
        "#{loc2.city}"  => lodge2.min_capacity }
      expect(ev.assigned_hospitality_beds).to eq(result)
    end
  end

  describe '#load_locality_summary' do
    let(:loc) { create(:locality) }
    let(:usr) { create(:user, locality: loc) }
    let(:ev)  { create(:event) }

    describe 'returns a hash' do
      it 'successfully' do
        ev = build_stubbed(:event_with_registrations)

        expect(ev.load_locality_summary.class).to eq(Hash)
      end

      it 'of stats per participating locality' do
        create(:registration, event: ev, user: usr)

        locality_city = loc.city

        stats = ev.load_locality_summary
        expect(stats[loc.city]).to eq(stats[locality_city])
      end

      it "that contains a locality's attandance totals" do
        create(:registration, event: ev, user: usr)

        stats = ev.load_locality_summary
        expect(stats[loc.city]['grand_total']).to eq(1)
        expect(stats[loc.city]['total_yp']).to eq(0)
        expect(stats[loc.city]['total_serving_ones']).to eq(0)
        expect(stats[loc.city]['total_helpers']).to eq(0)
        expect(stats[loc.city]['yp_so_ratio']).to eq('--')
      end

      it "that contains a locality's actual totals" do
        create(:registration, event: ev, user: usr)

        stats = ev.load_locality_summary
        # TODO: Refactor code - each calculation should be a single method
        # Pull each expectation out into it's own test & refactor method...
        expect(stats[loc.city]['actual_grand_total']).to eq('[--]')
        expect(stats[loc.city]['actual_total_yp']).to eq('[--]')
        expect(stats[loc.city]['actual_total_serving_ones']).to eq('[--]')
        expect(stats[loc.city]['actual_total_trainees']).to eq('[--]')
        expect(stats[loc.city]['actual_total_helpers']).to eq('[--]')
        # expect(stats[loc.city]['actual_amount_paid']).to eq(...)
        # expect(stats[loc.city]['balance']).to eq('[--]')
      end

      # it "that contains a locality's actual totals" do
      #   create(:registration, event: ev, user: usr)

      #   ev.load_locality_summary
      #   expect(true)
      # end
    end
  end
end
