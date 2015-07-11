require 'rails_helper'

feature 'User manages event localities' do
  let (:authed_admin) { create_logged_in_admin }
  let (:event) { create(:event_with_registrations) }

  context 'Show view' do
    it 'Displays Locality name' do
      locality = event.localities.sample

      visit event_locality_path(event, locality, authed_admin)

      expect(page).to have_content(locality.city)
    end

    it 'List locality users' do
      locality = event.localities.sample

      visit event_locality_path(event, locality, authed_admin)

      locality.users.all.each do |user|
        expect(page).to have_content(user.name)
      end
    end

    it 'List registered users form locality' do
      locality = event.localities.sample
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
