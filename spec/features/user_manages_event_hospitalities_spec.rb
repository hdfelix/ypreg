require 'rails_helper'

feature 'User adds an event hospitality location' do
  let (:authed_admin) {
    create_logged_in_admin
  }
	before(:all) do
		@event = create(:event)
	end

  scenario '- adds one event hospitality'
  scenario '- adds multiple event hospitalities'
end



