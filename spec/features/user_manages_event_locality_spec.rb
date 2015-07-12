require 'rails_helper'

feature 'User manages event localities' do
  let (:authed_admin) { create_logged_in_admin }

  context 'Show view' do
    it 'Displays Locality name' do

      event     = create(:event_with_registrations)
      person    = event.registrations.sample.user
      locality  = person.locality

      visit event_locality_path(event, locality, authed_admin)
      expect(page).to have_content(locality.city)
    end

    it 'Displays Locality contact name' do
      event     = create(:event_with_registrations)
      person    = event.registrations.sample.user
      locality  = person.locality
      
      visit event_locality_path(event, locality, authed_admin)

      expect(page).to have_content(locality.contact_name)
    end

    it 'List locality users' do
      event     = create(:event_with_registrations)
      person    = event.registrations.sample.user
      locality  = person.locality

      visit event_locality_path(event, locality, authed_admin)

      locality.users.all.each do |user|
        expect(page).to have_content(user.name)
      end
    end

    it 'List registered users form locality' do
      event     = create(:event_with_registrations)
      person    = event.registrations.sample.user
      locality  = person.locality
      registrations = event.localities.find(locality).registrations(event)

      visit event_locality_path(event, locality, authed_admin)

      registrations.all.each do |reg|
        within '#registrations' do
          expect(page).to have_content(reg.user.name)
        end
      end
    end
  end 
end
