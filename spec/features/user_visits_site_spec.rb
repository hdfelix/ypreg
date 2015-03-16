require 'rails_helper'

feature 'User can visit the home page' do
	scenario 'viewing the home page' do
		visit root_path
		expect(page).to have_content('Upcoming events')
	end

	#scenario 'page has a \'Home\' link' do
	#	visit root_path
	#	within('ul li') do
	#		expect(page).to have_content
	#	end
	#end
end

