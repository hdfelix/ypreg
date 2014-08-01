require 'rails_helper'

feature 'User creates an event' do
  let (:authed_admin) {
    create_logged_in_admin
  }
	before(:all) do
		@event = create(:event)
	end

	scenario '- can access the Events index' do
		visit events_path(authed_admin)
		expect(page).to have_content('Event')
		visit new_event_path(authed_admin)
		expect(page).to have_content('New event')
  end

	scenario ' - successfully with required fields' do
		visit new_event_path(authed_admin)
		expect{
			fill_in 'event[title]', with: @event.title
			select 'One-day', from: 'Event type'
			find("#event_location_id").find(:xpath, 'option[2]').select_option
			fill_in 'event_begin_date', with: @event.begin_date
			fill_in 'event_end_date', with: @event.end_date
			fill_in 'event_registration_cost', with: @event.registration_cost
			click_button 'Submit'
		}.to change(Event, :count).by(1)

		expect(current_path).to eq events_path
		expect(page).to have_content('Event was successfully created.')
		
		within 'h2' do
			expect(page).to have_content 'EVENTS'
		end

		expect(page).to have_content @event.title
	end

	scenario ' - with all fields' do
		visit new_event_path(authed_admin)

		expect{
			fill_in 'event[title]', with: @event.title
			find("#event_event_type").find(:xpath, "option[2]").select_option
			select 'Conference', from: 'Event type'
			find("#event_location_id").find(:xpath, 'option[2]').select_option
			fill_in 'event[begin_date]', with: @event.begin_date
			fill_in 'event[end_date]', with: @event.end_date
			fill_in 'event[registration_cost]', with: @event.registration_cost
			fill_in 'event[registration_open_date]', with: @event.registration_open_date
			fill_in 'event[registration_close_date]', with: @event.registration_close_date
			click_button 'Submit'
		}.to change(Event, :count).by(1)

		expect(current_path).to eq events_path
		expect(page).to have_content('Event was successfully created.')
		
		within 'h2' do
			expect(page).to have_content 'EVENTS'
		end

		expect(page).to have_content @event.title
	end

	scenario ' - unsuccessfully with no data' do
		visit new_event_path(authed_admin)
		expect{
			click_button 'Submit'
			expect(page).to have_content 'Error creating the event'
		}.not_to change(Event, :count)
	end	
	
	scenario ' - unsuccessfully with no title' do
		visit new_event_path(authed_admin)
		expect{
			click_button 'Submit'
			expect(page).to have_content 'Error creating the event'
		}.not_to change(Event, :count)
	end
end

feature 'User edits an event' do
  let (:authed_admin) {
    create_logged_in_admin
  }
	 
	before(:all) do
		@event = create(:event)
	end

	scenario ' - can access edit_event_path' do
		visit edit_event_path(@event,authed_admin)
    save_and_open_page
		expect(page).to have_content 'Edit Event'
	end

	scenario ' - successfully' do
		visit edit_event_path(@event)
		click_button 'Submit'
		expect(page).to have_content "Event was successfully updated."
	end
end

feature 'User destroys event' do

	before(:all) do
		@event = create(:event)
	end

	scenario 'Successfully' do
		visit '/events'
		expect{ 
			first(:link, 'Delete').click
		}.to change(Event, :count).by(-1)
	end
end
