require 'spec_helper'

feature 'User can visit the home page' do
	scenario 'viewing the home page' do
		visit root_path
		expect(page).to have_content('Registration')
	end

end

