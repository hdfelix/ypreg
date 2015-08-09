require 'rails_helper'

feature 'User manages attendance at an event' do
  let (:authed_admin) {
    create_logged_in_admin
  }

  scenario 'can see the total number of registrations for the event' do
    event = create(:event_with_registrations)

    visit event_attendances_path(event)

    expect(page).to have_content(event.registrations.count)
  end

  scenario 'can view all localities participating in the event' do
    event = create(:event_with_registrations)
    create(:registration, event: event, locality: event.localities.first)

    visit event_attendances_path(event)

    event.localities.each do |loc|
      expect(page).to have_content(loc.city)
    end
  end

  scenario 'can view all registrations for each locality' do
    event = create(:event)
    create(:registration, event: event, locality: event.localities.first)
    loc = create(:locality)
    user = create(:user, locality: loc)
    create(:registration, event: event, user: user)

    loc2 = create(:locality)
    user2 = create(:user, locality: loc2)
    create(:registration, event: event, user: user2)

    visit event_attendances_path(event)

    event_localities = EventLocality.includes(:locality).where(event: event)

    event_localities.each do |ev_loc|
      within("#loc_#{ev_loc.locality.id}") do
        expect(page).to have_content(ev_loc.locality_city)

        ev_loc.registrations.each do |reg|
          within("#user_#{reg.user.id}") do
          expect(page).to have_content(reg.user.name)
          expect(page).to have_content(reg.user.role)
          expect(page).to have_content('Edit')
          end
        end
      end
    end
  end
end
