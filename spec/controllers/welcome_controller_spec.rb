require 'rails_helper'

describe WelcomeController, type: :controller do
  before do
    sign_in_user
  end

  describe "GET 'index'" do
    it 'assigns future events to @events' do
      now = Time.zone.now
      event_over =
        create(:event, begin_date: 1.month.ago, end_date: 1.month.ago + 2.days)
      future_event = create(:event, begin_date: now + 8.days, end_date: now + 10.days)
      current_event = create(:event, begin_date: 1.day.ago, end_date: now + 1.day)

      get :index

      expect(assigns(:events)).to contain_exactly(future_event)
      expect(assigns(:events)).not_to include(current_event)
      expect(assigns(:events)).not_to include(event_over)
    end

    it 'returns http success' do
      get :index
      expect(response).to be_successful
    end

    it "renders 'index' template" do
      get :index
      expect(response).to render_template(:index)
    end
  end
end
