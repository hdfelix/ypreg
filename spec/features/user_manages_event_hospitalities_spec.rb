require 'rails_helper'

feature 'User adds Hospitality to event' do
  let (:authed_admin) {
    create_logged_in_admin
  }

  scenario 'can see event current hospitalities when assigning new ones' do
    event = create(:event)
    event.hospitalities << create(:hospitality)
    event.save

    visit event_hospitalities_path(event, authed_admin)

    expect(page).to have_content(event.hospitalities.first.name)
  end

  # TODO: Update to match new 'Manage Hospitality" code...
  # scenario 'can see unassigned lodgings that can be marked as event hospitalities' do
  #   event = create(:event)
  #   lodging = create(:lodging)

  #   visit event_path(event, authed_admin)

  #   click_link 'Add Hospitalities'

  #   save_and_open_page
  #   expect(page).to have_content 'Hospitality List'
  #   expect(page).to have_content 'Lodgings not providing hospitality'
  #   expect(page).to have_content lodging.name
  #   expect(page).to have_unchecked_field("event_lodging_ids_#{lodging.id}")
  # end

  # scenario 'can assign lodging as hospitality' do
  #   event = create(:event)
  #   lodging = create(:lodging)

  #   visit new_event_hospitality_path(event, authed_admin)

  #   check "event_lodging_ids_#{lodging.id}"
  #   click_button 'Save'

  #   expect(page).to have_content(lodging.name)
  # end

  scenario 'cannot add the same lodging twice'
end

feature 'User manages hospitality allocation by locality' do
  scenario 'assigns a hospitality to a locality'
  scenario 'cannot assign a hospitality that is already assigned to another locality'
end
