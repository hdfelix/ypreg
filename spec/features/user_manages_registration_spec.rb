require 'spec_helper'

feature 'User registers for an event' do
	scenario ' - can see a list of up-coming events in Welcome page' do
		@event = create(:event)

		visit root_path
		expect(page).to have_content ('Upcoming events')
		expect(page).to have_content (@event.title)
	end

	scenario ' - creates registration successfully'
end
