require 'spec_helper'

feature 'User creates an event' do
	scenario 'User can access the  index' do
		visit events_path
		expect(page).to have_content('New Event')
  end
	
	scenario 'User Adds a event'
	
end

