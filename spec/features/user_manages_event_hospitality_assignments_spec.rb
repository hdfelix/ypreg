require 'rails_helper'

feature 'User views hospitality_assignments page for event' do
  let (:authed_admin) {
    create_logged_in_admin
  }
	before(:all) do
		@event = create(:event_with_registrations)
  end

  # scenario "- can access the Event Hospitality Assignment index" do
  #   visit event_hospitality_assignments_path(@event, authed_admin)

  #   expect(page).to have_content('Hospitality Assignments')
  # end
end

