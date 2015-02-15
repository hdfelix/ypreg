require 'rails_helper'

feature 'Signed-out user views events' do
	scenario ' - can see a list of up-coming events in Welcome page' do
		@event = create(:event)

		visit root_path
		expect(page).to have_content ('Upcoming events')
		expect(page).to have_content (@event.title)
		expect(page).to have_content(format_date(@event.begin_date))
		expect(page).to have_content(format_date(@event.end_date))
	end

	scenario ' - before signing in sees \'sign in to register\' by events' do
		visit root_path
		expect(page).to have_content('Sign in to register')
		expect(page).to_not have_content('Register')
	end
end

feature 'Signed-in user' do
	let (:authed_admin) {
		create_logged_in_admin
	}

  before(:all) do
    @event = create(:event)
  end

	scenario '- can register for an event' do
		visit root_path(authed_admin)
		expect(page).to have_content('Register')
		expect(page).to_not have_content('Sign in to register')
	end

  #TODO: Fix default value of has_been_paid to FALSE
	#For now, client wants all payments to be done through locality
	# scenario ' - registers successfully with required fields' do

	# 	visit root_path(authed_admin)
	# 	first(:link, 'Register').click   #figure out how to click on the register button for @event (href="/registrations/new?event_id=1")

	# 	expect(page).to have_content('New Registration')

	# 	#@registration = build(:registration)

	# 	expect {
	# 		click_button 'Register'
	# 	}.to change(Registration, :count).by(1)
	# end

	#Create this test once we allow for individual payments through the site
	#scenario ' - with all fields'
end

feature 'User is unsuccessful in creating a registration' do
	let (:authed_admin) {
		create_logged_in_admin
	}

  before(:all) do
    @event = create(:event)
  end

	#scenario ' - sees error messages'  #Currently registration doesn't require any user input; if this changes we can write this test
end
