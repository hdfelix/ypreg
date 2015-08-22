require 'rails_helper'

describe Event, type: :model do
  describe 'Associations' do
    it { should belong_to :location }
    it { should have_many :registrations }
    it { should have_many(:users).through(:registrations) }
    it { should have_many(:localities).conditions(:uniq).through(:users) }
    it { should have_many :event_localities }
    it { should have_many :hospitalities }
    it { should have_many(:lodgings).conditions(:uniq).through(:hospitalities) }
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
    describe '#current' do
      it 'returns only events that are happening right now' do
        create(:event, end_date: 1.day.ago) # past event
        create(:event, begin_date: (Time.zone.now + 7.days)) # future event
        create(:event,
               begin_date: 1.day.ago,
               end_date: (Time.zone.now + 3.days)) # current event

        expect(Event.current.count).to eq (1)
      end
    end

    describe '#current' do
      it 'returns the current events (those happening at the moment)' do
        # scope :current, -> { where('begin_date < ? AND end_date > ?', Time.zone.now, Time.zone.now) }
          create(:event, end_date: 1.day.ago) # past event
          create(:event, begin_date: (Time.zone.now + 7.days)) # future event
          events = create_list(:event,2,
                 begin_date: 1.day.ago,
                 end_date: (Time.zone.now + 3.days)) # current event

          expect(Event.current.map(&:title)).to eq events.map(&:title)
      end
    end

    describe '#not_over' do
      # scope :not_over, -> { where('begin_date >= ? OR end_date > ?', Time.zone.now, Time.zone.now) }

    end

    describe '#in_the_future' do
      it 'returns only events that are happening in the future' do
        today = Time.zone.now

        create(:event,
               begin_date: 3.days.ago,
               end_date: 1.day.ago) # past event

        create(:event,
               begin_date: (today + 7.days),
               end_date: (today + 10.days)) # future event

        create(:event,
               begin_date: 1.day.ago,
               end_date: (today + 3.days)) # current event

        expect(Event.in_the_future.count).to eq (1)
      end
    end

    describe '#in_the_past' do
      it 'returns only events that already ended' do
        today = Time.zone.now

        create(:event,
               begin_date: 3.days.ago,
               end_date: 1.day.ago) # past event

        create(:event,
               begin_date: (today + 7.days),
               end_date: (today + 10.days)) # future event

        create(:event,
               begin_date: 1.day.ago,
               end_date: (today + 3.days)) # current event

        expect(Event.in_the_past.count).to eq (1)
      end
    end

    describe '#next' do
      it 'returns the next event chronologically from today' do
        # scope :next, -> { where('begin_date > ?', Time.zone.now).first }
        today = Time.zone.now
        create(:event, begin_date: (today - 1.day),
                          end_date: (today + 3.days))

        next_event = create(:event, begin_date: (today + 1.day),
                          end_date: (today + 3.days))

        expect(Event.next.title).to eq next_event.title
      end
    end
  end

  describe 'Methods' do
    describe '#remaining_spaces' do
      it 'returns the max capacity of spaces when there are no registrations' do
        event = build_stubbed(:event)

        expect(event.remaining_spaces).to eq(event.location.max_capacity)
      end

      it 'returns the remaining number of available registrations' do
        loc = build_stubbed(:location, max_capacity: 20)
        event = create(:event_with_registrations,
                       registrations_count: 3,
                       ensure_unique_locality: true,
                       location: loc)

        expect(event.remaining_spaces).to eq(17)
      end
    end
  end

  describe '#participating_localities' do
    it 'returns the localities participating in the event' do
      event = create(:event)
      loc1  = create(:locality)
      loc2  = create(:locality)
      usr1  = create(:user, locality: loc1)
      usr2  = create(:user, locality: loc2)

      create(:registration, event: event, user: usr1)
      create(:registration, event: event, user: usr2)

      participating_localities = event.participating_localities
      expect(participating_localities.count).to eq 2
      expect(participating_localities.map(&:id)).to contain_exactly(loc1.id, loc2.id)
    end
  end

  describe '#registered_saints_from_locality' do
    it 'returns a hash with registered users per locality' do
      event = create(:event_with_registrations,
                     registrations_count: 2,
                     ensure_unique_locality: true)
      loc  = event.participating_localities.first
      usr1 = event.registrations.first.user

      expect(event.registered_saints_from_locality(loc).map(&:id)).to eq([usr1.id])
    end
  end

  describe '#registered_saints_per_locality'

  describe '#total_registrations' do
    # TODO: test all new options {}
    # TODO: (refactored) test the actual registrations returned, not just count
    it 'returns the registrations per locality for the given role' do
      reg   = create(:registration, :yp)
      event = reg.event
      loc   = reg.user.locality
      role  = reg.user.role

      expect(event.total_registrations(role: role, locality: loc).count).to eq(1)
    end
  end

  describe '#registered_serving_ones' do
    it 'returns the number of serving ones from a locality attending the event' do
      reg   = create(:registration, :serving_one)
      other_reg = create(:registration, :serving_one)
      event = reg.event
      other_reg.event
      loc   = reg.user.locality

      expect(event.registered_serving_ones(loc).count).to eq(1)
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

    it 'does not return lodgings not registered as hospitality for an event' do
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

    it 'does not return lodgings registered as hospitality for an event' do
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
    let(:yp_usr) { create(:user, locality: loc) }
    let(:ev)  { create(:event) }

    describe 'returns a hash' do
      it 'successfully' do
        ev = build_stubbed(:event_with_registrations)

        expect(ev.load_locality_summary.class).to eq(Hash)
      end

      it 'of stats per participating locality' do
        create(:registration, event: ev, user: yp_usr)

        locality_city = loc.city

        stats = ev.load_locality_summary
        expect(stats[loc.city]).to eq(stats[locality_city])
      end

      it "that contains a locality's attandance totals" do
        create(:registration, event: ev, user: yp_usr)

        stats = ev.load_locality_summary
        expect(stats[loc.city]['grand_total']).to eq(1)
        expect(stats[loc.city]['total_yp']).to eq(1)
        expect(stats[loc.city]['total_serving_ones']).to eq(0)
        expect(stats[loc.city]['total_helpers']).to eq(0)
        expect(stats[loc.city]['yp_so_ratio']).to eq('--')
      end

      it "that contains a locality's actual totals" do
        create(:registration, event: ev, user: yp_usr, status: 'attended')
        actual_yp_users = 1
        actual_serving_ones = 0
        actual_trainees = 0
        actual_helpers = 0
        total = actual_yp_users + actual_serving_ones + actual_trainees + actual_helpers

        stats = ev.load_locality_summary
        # TODO: Refactor code - each calculation should be a single method
        # Pull each expectation out into it's own test & refactor method...
        expect(stats[loc.city]['actual_grand_total']).to eq(total)
        expect(stats[loc.city]['actual_total_yp']).to eq(actual_yp_users)
        expect(stats[loc.city]['actual_total_serving_ones']).to eq(actual_serving_ones)
        expect(stats[loc.city]['actual_total_trainees']).to eq(actual_trainees)
        expect(stats[loc.city]['actual_total_helpers']).to eq(actual_helpers)
      end

      # it "that contains a locality's actual totals" do
      #   create(:registration, event: ev, user: usr)

      #   ev.load_locality_summary
      #   expect(true)
      # end
    end
  end

  describe '#registration_open?' do
    it "returns true if today's date is inside the registration dates"
    it "returns false if today's date is outside registraiton close date"
  end

  describe '#over?' do
    it "return true if today's date is outside the event dates"
    it "returns false if today's date is inside the event dates"
  end
end
