require 'rails_helper'

feature 'User manages lodgings' do
  let (:authed_admin) {
    create_logged_in_admin
  }

  before(:all) do
    @lodging = create(:lodging)
  end

  scenario 'Can access lodging#index' do
    visit lodgings_path(authed_admin)

    expect(page).to have_content('LODGING')
    expect(page).to have_content('list of available lodging locations for conferences and retreats')
  end

  scenario 'Can add a lodging successfully' do
    not_a_contact_person = create(:user)

    visit lodgings_path(authed_admin)

    click_link 'New Lodging'

    expect(page).to have_content('NEW LODGING')

    fill_in 'lodging[name]', with: @lodging.name
    select "#{ Lodging::LODGING_TYPE[@lodging.lodging_type.to_i] }", from: 'lodging[lodging_type]'
    select "#{ @lodging.locality.city }", from: 'lodging[locality_id]'
    select "#{ not_a_contact_person.name }", from: 'contact_person_id'
    fill_in 'lodging[min_capacity]', with: @lodging.min_capacity
    fill_in 'lodging[max_capacity]', with: @lodging.max_capacity
    fill_in 'lodging[address1]', with: @lodging.address1
    fill_in 'lodging[address2]', with: @lodging.address2
    fill_in 'lodging[city]', with: @lodging.city
    find('#lodging_state_abbrv').find(:xpath, "option[@value=\'#{ @lodging.state_abbrv }\']").select_option
    fill_in 'lodging[zipcode]', with: @lodging.zipcode

    click_button 'Submit'
   
    expect(page).to have_content('Lodging was created successfully.')
    expect(page).to have_content(@lodging.name)

  end
end
