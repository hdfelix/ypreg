require 'rails_helper'

describe DashboardController, type: :controller do
  before(:example) do
    sign_in_user(double('user', role?: 'admin'))
  end

  describe 'GET :index' do
    it 'assigns current and futuer events as @current_or_future_events_present' do
      now = Time.zone.now
      event_over = create(:event, begin_date: 1.month.ago, end_date: 1.month.ago + 2.days)
      future_event = create(:event, begin_date: now + 8.days, end_date: now + 10.days)
      current_event = create(:event, begin_date: 1.day.ago, end_date: now + 1.day)

      get :index

      expect(assigns(:events)).to match_array([current_event, future_event])
      expect(assigns(:events)). to_not include(event_over)
      expect(assigns(:current_or_future_events_present)).to be true
    end

    it 'returns http success' do
      get :index
      expect(response).to be_success
    end

    it "renders 'index' template" do
      get :index
      expect(response).to render_template(:index)
    end
  end
end
