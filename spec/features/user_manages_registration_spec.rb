require 'spec_helper'

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
	let (:authed_user) {
		create_logged_in_user
	}
	before :each do
		@event = FactoryGirl.create(:event)
	end

	scenario '- can register for an event' do
		visit root_path(authed_user)
		expect(page).to have_content('Register')
		expect(page).to_not have_content('Sign in to register')
	end

	#For now, client wants all payments to be done through locality
	scenario ' - registers successfully with required fields' do

		visit root_path(authed_user)
		#save_and_open_page
		first(:link, 'Register').click   #figure out how to click on the register button for @event (href="/registrations/new?event_id=1")

		expect(page).to have_content(@event.title)
		expect(page).to have_content(@event.location.name)
		#expect(page).to have_content(@event.begin_date)
		#expect(page).to have_content(@event.end_date)
		expect(page).to have_content(@event.registration_cost)

		@registration = build(:registration)

		expect {
			#fill_in 'registration_date', with: @registration.registration_date
			#fill_in 'has_been_paid', with: false
			#find("#registration_payment_type").find(:xpath, "option[@value=\'#{@registration.payment_type}\']").select_option	
			click_button 'Register'
		}.to change(Registration, :count).by(1)
	end

	#Create this test once we allow for individual payments through the site
	scenario ' - with all fields'
end

feature 'User is unsuccessful in creating a registration' do
	scenario ' - sees error messages'
end
