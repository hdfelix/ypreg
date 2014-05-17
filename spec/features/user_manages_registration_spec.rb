require 'spec_helper'

feature 'User registers for an event' do
	scenario ' - can see a list of up-coming events in Welcome page' do
		@event = create(:event)

		visit root_path
		expect(page).to have_content ('Upcoming events')
		expect(page).to have_content (@event.title)
		expect(page).to have_content(format_date(@event.begin_date))
		expect(page).to have_content(format_date(@event.end_date))
		expect(page).to have_content('Register')
	end

	scenario '- can access new registration form' do
		visit root_path
		first(:link, 'Register').click
		expect(page).to have_content('New Registration')
	end
end

feature 'User creates registration successfully' do
	scenario ' - with required fields'
	scenario ' - with all fields'
end

feature 'User is unsuccessful in creating a registration' do
	scenario ' - sees error messages'
end
