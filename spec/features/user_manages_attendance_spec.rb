require 'rails_helper'

feature 'User manages attendance to event' do
  let (:authed_admin) {
    create_logged_in_admin
  }

  scenario 'can see event current hospitalities when assigning new ones' do
    event = create(:event_with_registrations)

    visit event_path(event, authed_admin)
    find('#manage').find(:xpath, "option[@value='Attendance']").select_option
    save_and_open_page

    # expect(page).to have_content(event.hospitalities.first.lodging_name)
  end
end
