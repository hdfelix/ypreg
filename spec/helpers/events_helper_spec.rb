require 'rails_helper'

describe EventsHelper do
  let(:speaking_brother) { build_stubbed(:user, role: 'speaking_brother') }
  let(:current_user) { build_stubbed(:user, role: 'speaking_brother') }
  let(:location) { create(:location, id: '1',
                                 address1: '1 Way',
                                 city: 'City',
                                 state_abbrv: 'CA',
                                 zipcode: '12345') }
  let(:event) { build_stubbed(:event, location: location) }

  describe '#display_event_manage_button?'

  describe '#event_location' do
    it "returns the event location formatted in safe html" do
      html = ''
      content_tag(:address) do
        html <<
          "#{location.address1} \n<br />\n #{location.city},"\
          "#{location.state_abbrv}&nbsp;&nbsp;#{location.zipcode}"
      end
      html.html_safe

      expect(event_location(event)).to eq(html)
    end
  end

  describe '#event_button_text_based_on_user_role' do
    context 'if the user is a speaking brother' do
      it 'changes the text of the first button on the event partial based on role' do
        expect(event_button_text_based_on_user_role).to eq 'View'
      end
    end
  end

  describe '#event_dates'
  describe '#event_registration_dates'
  describe '#display_event'
  describe '#display_max_cap'
  describe '#style_balance'
  describe '#show_attendance_menu_option?'
  describe '#background_check_tr'
  describe '#display_attendance_summary_for?'
end
