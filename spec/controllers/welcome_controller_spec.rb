require 'rails_helper'

describe WelcomeController, type: :controller do
  before(:example) do
    sign_in_user(double('user', role?: 'admin'))
  end

  describe "GET 'index'" do
    it 'assigns future events to @events' do
      now = Time.zone.now
      event_over =
        create(:event, begin_date: 1.month.ago, end_date: 1.month.ago + 2.days)
      future_event = create(:event, begin_date: now + 8.days, end_date: now + 10.days)
      current_event = create(:event, begin_date: 1.day.ago, end_date: now + 1.day)

      get :index

      expect(assigns(:events)).to match_array([future_event])
      expect(assigns(:events)).to_not include(current_event)
      expect(assigns(:events)).to_not include(event_over)
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
