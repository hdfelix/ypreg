require 'rails_helper'

feature 'User manages a location' do

	let(:authed_admin) {
		create_logged_in_admin
		@location = create(:location)
	}		

	scenario ' by acessing the index & new views' do
			visit locations_path(authed_admin)
			expect(page).to have_content('Location')
			visit new_location_path(authed_admin)
			expect(page).to have_content('New Location')
	end

	scenario '- creates a location successfully' do
		@location = build(:location)
		visit new_location_path
		expect {
			fill_in 'location_name', with: @location.name
			fill_in 'location[description]', with: @location.description
			fill_in 'location[address1]', with: @location.address1
			fill_in 'location[city]', with: @location.city
			find("#location_state_abbrv").find(:xpath, "option[@value=\'#{@location.state_abbrv}\']").select_option
			fill_in 'location[zipcode]', with: @location.zipcode
    save_and_open_page
			click_button 'Create Location'
		}.to change(Location, :count).by(1)
		expect(current_path).to eq locations_path
		expect(page).to have_content('Location was created successfully.')
	end

	scenario ' - edits a location' do
		create(:location)
		@loc = Location.all.first
		visit edit_location_path(@loc)
		fill_in 'location[name]', with: 'My location'
		click_button 'Update Location'
	end
end

feature 'User destroys location' do
	#before(:all) do
	#	@loc = create(:location)
	#end

	scenario ' - successfully' do
		create(:location)
		visit '/locations'
		expect{
			first(:link, 'Delete').click
	}.to change(Location, :count).by(-1)
	end
end
