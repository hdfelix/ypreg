require 'rails_helper'

describe Events::HospitalitiesController, type: :controller do
  let(:event) { create(:event) }
  before(:example) do
    sign_in_user(double('user', role?: 'admin'))
  end

  describe 'GET :index' do
    it 'assigns all the current event to @event' do
      get :index, event_id: event.id
      expect(assigns(:event)).to eq event
    end

    it 'assigns unassigned lodgings providing hospitality for the event' do
      create(:hospitality, event: event)
      lodging = create(:lodging)

      get :index, event_id: event.id

      expect(assigns(:lodgings)).to eq [lodging]
    end

    it 'assigns event hospitalities to @hospitalities' do
      hospitality = create(:hospitality, event: event)

      get :index, event_id: event.id

      expect(assigns(:hospitalities)).to eq [hospitality]
    end

    it 'is a success' do
      get :index, event_id: event.id
      expect(response).to have_http_status(:ok)
    end

    it 'renders the :index template' do
      get :index, event_id: event.id
      expect(response).to render_template(:index)
    end
  end

  describe 'POST add'
  describe 'PUT remove'
end
