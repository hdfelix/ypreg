require 'rails_helper'

#Admin users
feature 'Admin user  manages lodgings' do
  let (:authed_admin) { create_signed_in_user_by_role('admin') }

  scenario 'Can access lodging#index' do
    visit lodgings_path(authed_admin)

    within 'h2' do
      expect(page).to have_content('Lodgings')
    end
    expect(page).to have_content('list of available lodging locations for conferences and retreats')
  end

  scenario "can access lodging#new"  do
    visit new_lodging_path(authed_admin)
    within 'h2' do
      expect(page).to have_content('New Lodging')
    end
  end

  scenario 'can access lodging#show' do
    lodging = create(:lodging)
    visit lodging_path(lodging, authed_admin)

    within 'h2' do
      expect(page).to have_content(lodging.name)
    end
  end

  scenario 'can access lodging#edit' do
    lodging = create(:lodging)
    visit edit_lodging_path(lodging, authed_admin)

    within 'h2' do
      expect(page).to have_content('Edit Lodging')
    end

    expect(find('#lodging_name').value).to eq(lodging.name)
  end

  scenario 'Can add a lodging successfully' do
    lodging = create(:lodging)
    not_a_contact_person = create(:user)

    visit new_lodging_path(authed_admin)

    fill_in 'lodging[name]', with: lodging.name
    select "#{ Lodging::LODGING_TYPE[lodging.lodging_type.to_i] }", from: 'lodging[lodging_type]'
    select "#{ lodging.locality.city }", from: 'lodging[locality_id]'
    select "#{ not_a_contact_person.name }", from: 'contact_person_id'
    fill_in 'lodging[min_capacity]', with: lodging.min_capacity
    fill_in 'lodging[max_capacity]', with: lodging.max_capacity
    fill_in 'lodging[address1]', with: lodging.address1
    fill_in 'lodging[address2]', with: lodging.address2
    fill_in 'lodging[city]', with: lodging.city
    find('#lodging_state_abbrv').find(:xpath, "option[@value=\'#{ lodging.state_abbrv }\']").select_option
    fill_in 'lodging[zipcode]', with: lodging.zipcode

    click_button 'Submit'

    expect(page).to have_content('Lodging was created successfully.')
    expect(page).to have_content(lodging.name)
  end

  scenario 'edits a lodging' do
    lodging = create(:lodging, name: 'Original name')
    visit edit_lodging_path(lodging, authed_admin)

    fill_in 'lodging[name]', with: 'Edited name'
    click_button 'Submit'
    lodging.reload

    expect(lodging.name).to eq('Edited name')
  end

  scenario ' deletes a location successfully' do
    visit locations_path(authed_admin)

    expect { first(:link, 'Delete').click }.to change(Location, :count).by(-1)
  end
end


#SCYP users
feature 'SCYP user manages lodgings' do
  let (:authed_scyp) { create_signed_in_user_by_role('scyp') }

  scenario 'Can access lodging#index' do
    visit lodgings_path(authed_scyp)

    expect(page).to have_content('Lodging')
    expect(page).to have_content('list of available lodging locations for conferences and retreats')
  end

  scenario 'Can add a lodging successfully' do
    lodging = create(:lodging)
    not_a_contact_person = create(:user)

    visit lodgings_path(authed_scyp)

    click_link 'New Lodging'

    expect(page).to have_content('New Lodging')

    fill_in 'lodging[name]', with: lodging.name
    select "#{ Lodging::LODGING_TYPE[lodging.lodging_type.to_i] }", from: 'lodging[lodging_type]'
    select "#{ lodging.locality.city }", from: 'lodging[locality_id]'
    select "#{ not_a_contact_person.name }", from: 'contact_person_id'
    fill_in 'lodging[min_capacity]', with: lodging.min_capacity
    fill_in 'lodging[max_capacity]', with: lodging.max_capacity
    fill_in 'lodging[address1]', with: lodging.address1
    fill_in 'lodging[address2]', with: lodging.address2
    fill_in 'lodging[city]', with: lodging.city
    find('#lodging_state_abbrv').find(:xpath, "option[@value=\'#{ lodging.state_abbrv }\']").select_option
    fill_in 'lodging[zipcode]', with: lodging.zipcode

    click_button 'Submit'

    expect(page).to have_content('Lodging was created successfully.')
    expect(page).to have_content(lodging.name)
  end
end
