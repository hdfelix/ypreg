require 'rails_helper'

feature 'User adds an event lodging' do
  let (:authed_admin) {
    create_logged_in_admin
  }
	before(:all) do
		@event = create(:event)
	end

  scenario 'can add available lodgings to the event'
  scenario 'cannot add the same lodging twice'
end

feature 'User manages hospitality allocation by locality' do
  scenario 'assigns a hospitality to a locality'
  scenario 'cannot assign a hospitality that is already assigned to another locality'
end
