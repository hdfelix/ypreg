require 'rails_helper'

feature 'User manages attendance at an event' do
  let (:authed_admin) {
    create_logged_in_admin
  }

  scenario 'can see the total number of registrations for the event' do
    event = create(:event_with_registrations)

    visit event_attendances_path(event)

    expect(current_path).to eq(event_attendances_path(event))
    expect(page).to have_content(event.registrations.count)
  end

  scenario 'can view all localities participating in the event' do
    event = create(:event_with_registrations)
    create(:registration, event: event, locality: event.localities.first)

    visit event_attendances_path(event)
    expect(current_path).to eq(event_attendances_path(event))

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

    visit event_attendances_path(event)
    expect(current_path).to eq(event_attendances_path(event))

    event_localities = EventLocality.includes(:locality).where(event: event)

    event_localities.each do |ev_loc|
      within("#loc_#{ev_loc.locality.id}") do
        expect(page).to have_content(ev_loc.locality_city)

        ev_loc.registrations.each do |reg|
          within("#user_#{reg.user.id}") do
          expect(page).to have_content(reg.user.name)
          expect(page).to have_content(reg.user.role)
          expect(page).to have_content('Edit')
          end
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
    
    visit event_attendances_path(event)
    expect(current_path).to eq(event_attendances_path(event))
   
    within("#user_#{user.id}") do
      click_link_or_button "#{user.name}"
    end

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
    expect(page).to have_content('Back')
    expect(page).to have_content('Edit')
  end

  scenario "can edit a single Registration Record by clicking on the user name" do
    event = create(:event)
    loc = create(:locality)

    user = create(:user, locality: loc)
    hosp = create(:hospitality,
                  event: event,
                  lodging: create(:lodging),
                  locality: loc)
    reg = create(:registration, event: event, user: user, hospitality: hosp)

    visit event_attendances_path(event)
    expect(current_path).to eq(event_attendances_path(event))

    within("#user_#{user.id}") do
      click_link_or_button "Edit"
    end

    save_and_open_page
    check('registration[has_medical_release_form]')
    click_button 'Submit'

    expect(page).to have_content('Edit')
    # expect(page).to have_content(user.name)
    # expect(page).to have_content(user.gender)
    # expect(page).to have_content(user.age)
    # expect(page).to have_content(user.locality.city)
    # expect(page).to have_content("$#{reg.payment_adjustment}.00")
    # expect(page).to have_content(display_yes_no(reg.has_been_paid))
    # expect(page).to have_content(display_yes_no(reg.has_medical_release_form))
    # expect(page).to have_content(reg.hospitality.lodging.name)
    # expect(page).to have_content(reg.hospitality.lodging.address1)
    # expect(page).to have_content(reg.hospitality.lodging.address2)
    # expect(page).to have_content(reg.hospitality.lodging.city)
    # expect(page).to have_content(reg.hospitality.lodging.contact_person.name)
    # expect(page).to have_content(format_phone_number(reg.hospitality.lodging.contact_person.cell_phone))
    # expect(page).to have_content(format_phone_number(reg.hospitality.lodging.contact_person.home_phone))
    # expect(page).to have_content(reg.hospitality.lodging.contact_person.email)
  end
end
