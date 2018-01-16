require 'rails_helper'

feature "User visits Event#show" do
  let(:authed_admin) {
    create_logged_in_admin
  }

  it "has a Localities List button" do
    ev = create(:event)
    visit event_path(ev, authed_admin)

    expect(page).to have_content("Localities List")
  end

  context 'Localities List button' do
    it 'takes you to events#localities#index where all localities are listed' do
      ev = create(:event)
      localities = create_list(:locality, 2)
      visit event_path(ev, authed_admin)
      click_link 'Localities List'

      expect(page).to have_content(localities.first.city)
      expect(page).to have_content(localities.second.city)
    end
  end
end

feature 'User manages event localities' do
  let(:authed_admin) { create_logged_in_admin }

  context 'Show view' do
    let(:event) { create(:event_with_registrations) }
    let(:person) { event.registrations.sample.user }
    let(:locality) { person.locality }

    it 'Displays a tip with Check Payable To information' do
      visit event_locality_path(event, locality, authed_admin)
      within('#tip') do
        expect(page).to have_content('Checks should be made out to')
        expect(page).to have_content('Church in Anaheim - YP')
        expect(page).to have_content('and presented to the registration table')
        expect(page).to have_content('when arriving at the conference.')
      end
    end

    it 'Displays Locality name' do
      visit event_locality_path(event, locality, authed_admin)
      expect(page).to have_content(locality.city)
    end

    it 'Displays Locality contact name' do
      visit event_locality_path(event, locality, authed_admin)
      expect(page).to have_content(locality.contact_name)
    end

    it 'Displays the registration closing date' do
      visit event_locality_path(event, locality, authed_admin)
      expect(page).to have_content("Registration will close on: #{format_date(event.registration_close_date)}")
    end

    it 'it has the following sections: Attendance Breakdown, Available Hospitalities \
        Registered Saints, Locality Saints, Payments' do
      visit event_locality_path(event, locality, authed_admin)

      expect(page).to have_content('Attendance Breakdown')
      expect(page).to have_content('Available Hospitalities')
      expect(page).to have_content('Registered Saints')
      expect(page).to have_content('Locality Saints')
      expect(page).to have_content('Payments')
    end

    it 'Displays the attendance breakdown'

    it 'List registered users form locality' do
      registrations = event.localities.find(locality).registrations(event)

      visit event_locality_path(event, locality, authed_admin)
      registrations.all.each do |reg|
        within '#registrations' do
          expect(page).to have_content(reg.user.name)
          expect(page).to have_content(reg.user.age.capitalize)
          expect(page).to have_content(display_yes_no(reg.conference_guest))
          expect(page).to have_content(display_yes_no(reg.has_medical_release_form))
          # expect(page).to have_content(display_hosptitality_assignment(reg))
          expect(page).to have_content(reg.vehicle_seating_capacity)
        end
      end
    end

    it 'List locality users' do
      visit event_locality_path(event, locality, authed_admin)
      locality.users.all.each do |user|
        expect(page).to have_content(user.name)
      end
    end
  end
end
