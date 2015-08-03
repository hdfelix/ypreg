require 'rails_helper'

feature 'User manages a single attendance record' do
  let (:authed_admin) {
    create_logged_in_admin
  }
	before(:each) { @event = create(:event) }
  after(:each) { @event.destroy }
end
