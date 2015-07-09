require 'rails_helper'

feature 'User manages event localities' do
  let (:authed_admin) { create_logged_in_admin }
  let (:event) { create(:event_with_registrations) }

  scenario 'can access an event locality' do
    locality = event.localities.sample
    visit event_locality_path(event, locality, authed_admin)

    expect(page). to have_content(locality.city)
  end 
end
