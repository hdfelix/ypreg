require 'rails_helper'

feature 'User manages attendance to event' do
  let (:authed_admin) {
    create_logged_in_admin
  }

  scenario 'can see event current hospitalities when assigning new ones'
end
