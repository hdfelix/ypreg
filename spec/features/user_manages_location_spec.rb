require 'rails_helper'

# Admin users
feature 'Admin user manages a location' do
  let(:authed_admin) { create_signed_in_user_by_role('admin') }

  scenario "can access the 'index' view" do
    visit locations_path(authed_admin)
    within 'h2' do
      expect(page).to have_content('Locations')
    end
  end

  scenario "can access location#new"  do
    visit new_location_path(authed_admin)
    within 'h2' do
      expect(page).to have_content('New Location')
    end
  end

  scenario 'creates a location successfully' do
    location = build_stubbed(:location, name: 'new location')

    visit new_location_path(authed_admin)

    expect do
      fill_in 'location[name]', with: location.name
      fill_in 'location[description]', with: location.description
      fill_in 'location[address1]', with: location.address1
      fill_in 'location[city]', with: location.city
      find('#location_state_abbrv')
        .find(:xpath, "option[@value=\'#{location.state_abbrv}\']")
        .select_option
      fill_in 'location[zipcode]', with: location.zipcode
      click_button 'Submit'
    end.to change(Location, :count)

    expect(current_path).to eq locations_path
    expect(page).to have_content('Location was created successfully.')
  end

  scenario 'edits a location' do
    location = create(:location, name: 'Original name')

    visit edit_location_path(location, authed_admin)
    fill_in 'location[name]', with: 'Edited name'
    click_button 'Submit'
    location.reload

    expect(location.name).to eq('Edited name')
  end

  scenario ' deletes a location successfully' do
    p "TESTING: Locations before create_list: #{ Location.all.count }"
    create_list(:location,2, max_capacity: 50)
    p "TESTING: Locations after create_list: #{ Location.all.count }"

    visit locations_path(authed_admin)

    expect { first(:link, 'Delete').click }.to change(Location, :count).by(-1)
    p "TESTING: Locations after delete: #{ Location.all.count }"
  end
end

# SCYP user
feature 'SCYP user manages a location' do
  let(:authed_scyp) { create_signed_in_user_by_role('scyp') }

  scenario "can access the 'index' view" do
    visit locations_path(authed_scyp)
    within 'h2' do
      expect(page).to have_content('Locations')
    end
  end

  scenario "can access the 'new' view"  do
    visit new_location_path(authed_scyp)
    within 'h2' do
      expect(page).to have_content('New Location')
    end
  end

  scenario 'creates a location successfully' do
    location = build_stubbed(:location, name: 'new location')

    visit new_location_path(authed_scyp)

    expect do
      fill_in 'location[name]', with: location.name
      fill_in 'location[description]', with: location.description
      fill_in 'location[address1]', with: location.address1
      fill_in 'location[city]', with: location.city
      find('#location_state_abbrv')
        .find(:xpath, "option[@value=\'#{location.state_abbrv}\']")
        .select_option
      fill_in 'location[zipcode]', with: location.zipcode
      click_button 'Submit'
    end.to change(Location, :count)

    expect(current_path).to eq locations_path
    expect(page).to have_content('Location was created successfully.')
  end

  scenario 'edits a location' do
    location = create(:location, name: 'Original name')

    visit edit_location_path(location, authed_scyp)
    fill_in 'location[name]', with: 'Edited name'
    click_button 'Submit'
    location.reload

    expect(location.name).to eq('Edited name')
  end

  scenario ' deletes a location successfully' do
    p "TESTING: Locations before create_list: #{ Location.all.count }"
    create_list(:location,2, max_capacity: 50)
    p "TESTING: Locations after create_list: #{ Location.all.count }"

    visit locations_path(authed_scyp)

    expect { first(:link, 'Delete').click }.to change(Location, :count).by(-1)
    p "TESTING: Locations after delete: #{ Location.all.count }"

  end
end
