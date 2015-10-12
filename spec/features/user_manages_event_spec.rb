require 'rails_helper'

feature 'User creates an event' do
  let (:authed_admin) { create_logged_in_admin }
  before(:each) { @event = create(:event) }

  scenario '- can access the Events index' do
    visit events_path(authed_admin)
    expect(page).to have_content('Event')

    visit new_event_path(authed_admin)
    expect(page).to have_content('NEW EVENT')
  end

  scenario ' - successfully with required fields' do
    visit new_event_path(authed_admin)
    expect do
      fill_in 'event[title]', with: @event.title
      select 'One-day', from: 'Event type'
      find('#event_location_id').find(:xpath, 'option[2]').select_option
      fill_in 'event_begin_date', with: @event.begin_date
      fill_in 'event_end_date', with: @event.end_date
      fill_in 'event_registration_cost', with: @event.registration_cost
      click_button 'Submit'
    end.to change(Event, :count).by(1)

    expect(current_path).to eq events_path
    expect(page).to have_content('Event was successfully created.')

    within 'h2' do
      expect(page).to have_content 'Events'
    end

    expect(page).to have_content @event.title
  end

  scenario ' - with all fields' do
    visit new_event_path(authed_admin)

    expect do
      fill_in 'event[title]', with: @event.title
      fill_in 'event[description]', with: @event.description
      find('#event_event_type').find(:xpath, 'option[2]').select_option
      select 'Conference', from: 'Event type'
      find('#event_location_id').find(:xpath, 'option[2]').select_option
      fill_in 'event[begin_date]', with: @event.begin_date
      fill_in 'event[end_date]', with: @event.end_date
      fill_in 'event[registration_cost]', with: @event.registration_cost
      fill_in 'event[registration_open_date]', with: @event.registration_open_date
      fill_in 'event[registration_close_date]', with: @event.registration_close_date
      click_button 'Submit'
    end.to change(Event, :count).by(1)

    expect(current_path).to eq events_path
    expect(page).to have_content('Event was successfully created.')

    within 'h2' do
      expect(page).to have_content 'Events'
    end

    expect(page).to have_content @event.title
    expect(page)
      .to have_content Event::EVENT_TYPE
      .detect { |a| a.include?(@event.event_type) }[0]
    expect(page).to have_content format_date(@event.begin_date)
    expect(page).to have_content format_date(@event.end_date)
    expect(page).to have_content format_date(@event.registration_open_date)
    expect(page).to have_content format_date(@event.registration_close_date)
    expect(page).to have_content "$#{@event.registration_cost}.00"
  end

  scenario ' - unsuccessfully with no data' do
    visit new_event_path(authed_admin)
    expect do
      click_button 'Submit'
      expect(page).to have_content 'Error creating the event'
    end.not_to change(Event, :count)
  end

  scenario ' - unsuccessfully with no title' do
    visit new_event_path(authed_admin)
    expect do
      click_button 'Submit'
      expect(page).to have_content 'Error creating the event'
    end.not_to change(Event, :count)
  end
end

feature 'User copies an event' do
  let (:authed_admin) { create_logged_in_admin }
  before(:each) { @event = create(:event) }

  scenario 'successfully' do 
    visit events_path(authed_admin)
    click_link 'Copy'
    expect(page). to have_content "#{@event.title} (copy)"
  end
end

feature 'User edits an event' do
  let (:authed_admin) { create_logged_in_admin }
  before(:each) { @event = create(:event) }

  scenario ' - can access edit_event_path' do
    visit edit_event_path(@event, authed_admin)
    expect(page).to have_content 'Edit Event'
  end

  scenario ' - successfully' do
    visit edit_event_path(@event, authed_admin)
    click_button 'Submit'
    expect(page).to have_content 'Event was successfully updated.'
  end
end

feature 'User destroys event' do
  let (:authed_admin) { create_logged_in_admin }
  before(:each) { @event = create(:event) }

  context 'Successfully' do
    it 'removes event localities' do
      visit events_path(authed_admin)
      first(:link, 'Delete').click
      expect(EventLocality.where(event: @event).count).to eq 0
    end

    it 'removes event registrations' do
      visit events_path(authed_admin)
      first(:link, 'Delete').click
      expect(Registration.where(event: @event).count).to eq 0
    end

    it 'removes the event' do
      visit events_path(authed_admin)
      expect do
        first(:link, 'Delete').click
      end.to change(Event, :count).by(-1)
    end
  end
end
