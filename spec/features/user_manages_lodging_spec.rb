require 'rails_helper'

feature 'User manages lodgings' do
  let (:authed_admin) {
    create_logged_in_admin
  }

  before(:all) do
    @lodging = create(:lodging)
  end

  scenario 'Creates a lodging'
end
