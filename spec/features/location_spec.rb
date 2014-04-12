require 'spec_helper'

feature 'User can manage a Location' do
	scenario 'User can access the location index' do
		visit locations_path
		expect(page).to have_content('Location')
	end
	
	scenario 'Adds a location' do
		visit locations_path
		expect{
			click_link 'Add Location'
			fill_in 'location_title', with: 'New location'
			fill_in 'location_addressline1', with: '123 Street'
			fill_in 'location_city', with: 'Newtown'
			fill_in 'location_state', with: 'CA'
			fill_in 'locaiton_zipcode', with: '00000'
			click_button 'Create Location'
		}.to change(Location, :count).by(1)
	end	

	scenario 'Views the collection of locations'

	scenario 'Edits a location'

	scenario 'Updates a location'

	scenario 'Deletes a location'
end
