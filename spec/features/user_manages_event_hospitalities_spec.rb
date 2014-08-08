require 'rails_helper'

feature 'User adds an event hospitality location' do
  let (:authed_admin) {
    create_logged_in_admin
  }
	before(:all) do
		@event = create(:event)
	end

  #scenario '- clicks on \'Add Event Hospitality\'' do
  #  #visit hospitality_assign_path(authed_admin)
  #  visit event_path(@event, authed_admin)
  #  wait_for_ajax
  #  expect(page).to have_content('Add')
  #  #find('#available_hospitalities_id').find(:xpath, 'option[1]').select_option
  #end
  scenario '- adds one event hospitality'
  scenario '- adds multiple event hospitalities'
end



