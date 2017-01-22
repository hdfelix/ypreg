require 'rails_helper'

feature 'Locality Contact creates an event registration' do
  let(:authed_admin) { create_signed_in_user_by_role('admin') }
  let(:authed_loc_contact) { create_signed_in_user_by_role('loc_contact') }
  before(:each) { @event = create(:event) }

  context 'When there are no registrations from their locality' do
    it 'the locality does not show up in the Locality Summaries list' do
      visit event_path(@event, authed_loc_contact)
      within('div#locality_summary') do
        within('table') do
          expect(page).not_to have_content("#{authed_loc_contact.locality.city}")
        end
      end
    end

    it 'there is a button to add registrations for there locality' do
      visit event_path(@event, authed_loc_contact)
      within('div#locality_summary') do
        expect(page).to have_content("Add registrations for #{authed_loc_contact.locality.city}")
      end
    end
  end

  context 'When there is at least one registration from their locality' do
    before(:each) do
      user = create(:user, role: 'yp', locality: authed_loc_contact.locality)
      create(:registration, event: @event, user: user)
    end

    it 'Their locality is listed in the Locality Summaries table' do
      visit event_path(@event, authed_loc_contact)
      within('div#locality_summary') do
        within('table') do
          expect(page).to have_content("#{authed_loc_contact.locality.city}")
        end
      end
    end

    it 'The button to add their locality is not visible' do
      visit event_path(@event, authed_loc_contact)
      within('div#locality_summary') do
        expect(page).not_to have_content("Add registrations for #{authed_loc_contact.locality.city}")
      end
    end
  end

  context 'Can create a registration' do
    before(:each) do
      @locality = authed_loc_contact.locality
      @user = create(:user, role: 'scyp', locality: @locality)
      @reg = create(:registration, event: @event, user: @user, vehicle_seating_capacity: 5)
    end

    it 'from Registrations#new' do
      visit event_locality_path(@event, @locality, authed_loc_contact)
      within('div#locality_saints') do
        page.all('a', text: 'Register')[0].click
      end

      fill_in 'registration[vehicle_seating_capacity]', with: 5
      click_button 'Register'

      within('div#locality_summary') do
        localities = 2
        balance = localities * @event.registration_cost
        expect(page).to have_content("#{@locality.city} #{localities}")
        expect(page).to have_content("$#{balance}.00")
      end
    end

    it 'Vehicle seating capacity is visible in event#registrations' do
      visit event_registrations_path(@event, authed_admin)
      within_table('registrations') do
        expect(page).to have_content(@reg.vehicle_seating_capacity)
      end
    end
  end
end
