require 'rails_helper'

feature 'Signed-out user views events' do
  let!(:event) { create(:event) }

	scenario ' - can see a list of up-coming events in Welcome page' do
		visit root_path
		expect(page).to have_content 'Upcoming events'
		expect(page).to have_content event.title
		expect(page).to have_content format_date(event.begin_date)
		expect(page).to have_content format_date(event.end_date)
	end

	scenario ' - before signing in sees \'sign in to register\' by events' do
		visit root_path
		expect(page).to have_content('Sign in to register')
		expect(page).to_not have_content('Register')
	end
end

feature 'Signed-in user' do
	let(:authed_admin) { create_logged_in_admin }
  let!(:event) { create(:event) }

	scenario '- can register for an event' do
		visit root_path(authed_admin)
		expect(page).to have_content('Register')
		expect(page).to_not have_content('Sign in to register')
	end

  scenario '- can view list of registered users' do
    visit event_registrations_path(event, authed_admin)

    expect(page).to have_content('list of people attending')
  end

  scenario '- can see expected registered user info' do
    reg = create(:registration, :yp, event: event)

    visit event_registrations_path(event, authed_admin)
    # within(:css, "#reg-#{reg.id}") do

      expect(page).to have_content(reg.user.name)
      expect(page).to have_content(reg.user.role.capitalize)
      expect(page).to have_content(reg.user.gender.to_s[0])
      expect(page).to have_content(reg.user.age)
      expect(page).to have_content(reg.user.locality.city)
      expect(page).to have_content(reg.conference_guest.to_s.capitalize)
      expect(page).to have_content("$#{reg.payment_adjustment}.00")
      expect(page).to have_content(display_yes_no(reg.has_been_paid))
      expect(page).to have_content(display_yes_no(reg.attend_as_serving_one))
      expect(page).to have_content(display_yes_no(reg.has_medical_release_form))
      expect(page).to have_content("Show")
      expect(page).to have_content("Edit")
    # end
  end

  # TODO: (ask) link_to isnt'working
  # scenario "- can click 'show' and view single registration details" do
  #   reg = create(:registration, :yp,  event: @event)

  #   visit event_registrations_path(@event, authed_admin)
  #   within("tr#reg-#{reg.id}") do
  #     click_link('Show')
  #     expect(page).to have_content(reg.user.name)
  #   end
  # end

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
	let(:authed_admin) {
		create_logged_in_admin
	}

	#scenario ' - sees error messages'  #Currently registration doesn't require any user input; if this changes we can write this test
end
