require 'rails_helper'

feature 'User manages hospitality registration assignments' do
  let(:authed_admin) do
    create_logged_in_admin
  end

  let(:locality) { event.localities.first }
  let(:user) { create(:user) }
  let(:event) { create(:event) }

  scenario 'can access the hospitality registration assignments #index' do
    event = create(:event)

    visit event_hospitality_registration_assignments_path(event, authed_admin)

    expect(page).to have_content('Saint to Hospitality Assignments')
  end

  scenario 'User manages hospitality registration assignments for a locality' do
    create(:registration, event: event, user: user)

    visit event_hospitality_registration_assignment_path(event.id, locality.id, authed_admin)

    expect(page).to have_content("Hospitality Assignments - #{locality.city.capitalize}")
  end
end
