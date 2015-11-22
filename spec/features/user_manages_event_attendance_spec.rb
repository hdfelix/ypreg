require 'rails_helper'

feature 'User manages attendance at an event' do
  before(:example) do
    @authed_admin = create_signed_in_user_by_role('admin')
  end

  scenario 'can see the total number of registrations for the event', js: true do
    event = create(:event_with_registrations, :current_event)

    visit event_path(event)
    within('div#event-info-btn-group') do
      click_button('manage')
      wait_for_ajax
      click_link('Attendance')
    end

    expect(page).to have_content("Registrations: #{event.registrations.count}")
  end

  scenario 'can view all localities participating in the event', js: true do
    event = create(:event_with_registrations,:current_event, registrations_count: 5)
    create(:registration, event: event, locality: event.localities.first)

    visit event_path(event)

    within('div#event-info-btn-group') do
      click_button('manage')
      wait_for_ajax
      click_link('Attendance')
    end

    event.localities.each do |loc|
      expect(page).to have_content(loc.city)
    end
  end

  scenario 'can view all registrations for each locality' do
    event = create(:event)
    loc = create(:locality)
    user = create(:user, locality: loc)
    create(:registration, event: event, user: user)
    loc = create(:locality)

    user = create(:user, locality: loc)
    create(:registration, event: event, user: user)

    loc2 = create(:locality)
    user2 = create(:user, locality: loc2)
    create(:registration, event: event, user: user2)

    visit "events/#{event.id}/registrations?view=attendance"

    event_localities = EventLocality.includes(:locality).where(event: event)

    event_localities.each do |ev_loc|
      within("#loc_#{ev_loc.locality.id}") do
        expect(page).to have_content(ev_loc.locality_city)

        ev_loc.registrations.each do |reg|
          expect(page).to have_content(reg.user.name)
          expect(page).to have_content(reg.user.role)
          expect(page).to have_content('Update')
        end
      end
    end
  end

  scenario 'can view an user registration record' do
    event = create(:event)
    loc = create(:locality)

    user = create(:user, locality: loc)
    hosp = create(:hospitality,
                  event: event,
                  lodging: create(:lodging),
                  locality: loc)
    reg = create(:registration, event: event, user: user, hospitality: hosp)

    visit "events/#{event.id}/registrations?view=attendance"

    # within("#user_#{user.id}") do
      click_link_or_button "#{user.name}"
    # end

    expect(page).to have_content(user.name)
    expect(page).to have_content(user.gender)
    expect(page).to have_content(user.age)
    expect(page).to have_content(user.locality.city)
    expect(page).to have_content("$#{reg.payment_adjustment}.00")
    expect(page).to have_content(display_yes_no(reg.has_been_paid))
    expect(page).to have_content(display_yes_no(reg.has_medical_release_form))
    expect(page).to have_content(reg.hospitality.lodging.name)
    expect(page).to have_content(reg.hospitality.lodging.address1)
    expect(page).to have_content(reg.hospitality.lodging.address2)
    expect(page).to have_content(reg.hospitality.lodging.city)
    expect(page).to have_content(reg.hospitality.lodging.contact_person.name)
    expect(page).to have_content(format_phone_number(reg.hospitality.lodging.contact_person.cell_phone))
    expect(page).to have_content(format_phone_number(reg.hospitality.lodging.contact_person.home_phone))
    expect(page).to have_content(reg.hospitality.lodging.contact_person.email)
    expect(page).to have_content('Edit')
    expect(page).to have_content('Back')
  end

  scenario "can access the edit an attendance (registration) record by clicking on the user name" do
    event = create(:event)
    loc = create(:locality)

    user = create(:user, locality: loc)
    hosp = create(:hospitality,
                  event: event,
                  lodging: create(:lodging),
                  locality: loc)
    reg = create(:registration, event: event, user: user, hospitality: hosp)

    visit "events/#{event.id}/registrations?view=attendance"

    # within("#user_#{user.id}") do
    #  click_link_or_button "Edit"
    # end
    click_link_or_button "Update"

    check('registration[has_medical_release_form]')
    select('attended', from: 'registration[status]')
    click_button 'Update'
  end

  scenario "Can see a warning if background check is expired"
  scenario "Can see Hospitality information if hospitality has been assigned"
  scenario "Can see a notice and a link to add hospitality if it has not been added"
  scenario "Cannot update status to 'attended' if background check is expired"
end
