require 'rails_helper'

describe Events::AttendancesController, type: :controller do
	describe 'GET #index' do
		before(:each) do
			sign_in(:admin)
		end

		it 'displays each attending locality' do
			event = create(:event_with_registrations)
			other_event = create(:event_with_registrations)

			get :index, event_id: event.id

			expect(assigns(:registrations).map(&:id)).to match_array event.registrations.map(&:id)
			expect(assigns(:registrations).map(&:id)).not_to include other_event.registrations.map(&:id)
		end

		it 'renders the :index view' do
			event = create(:event_with_registrations)
			get :index, event_id: event.id
			expect(response).to render_template :index
		end
	end
end
