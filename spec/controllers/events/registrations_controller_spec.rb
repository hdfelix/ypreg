require 'rails_helper'

describe Events::RegistrationsController, type: :controller do
  let(:event) { create(:event_with_registrations) }
  before(:example) do
    sign_in_user
  end

  describe 'GET #index' do
    it 'assigns event to @event' do
      get :index, params: { event_id: event.to_param }
      expect(assigns(:event)).to eq event
    end

    it 'assigns event registrations to @registrations' do
      get :index, params: { event_id: event.to_param }
      # TODO: registrations are sorted by city but haven't found reliable way to test
      # event.registrations.sort_by { |reg| reg.locality.city }
      expect(assigns(:registrations).map(&:id))
        .to match_array(event.registrations.map(&:id))
    end

    it 'is :ok' do
      get :index, params: { event_id: event.to_param }
      expect(response).to have_http_status(:ok)
    end

    context "without params[:view] == 'attendance'" do
      it 'renders the :index view' do
        get :index, params: { event_id: event.id }
        expect(response).to render_template :index
      end
    end

    context "with params[:view] == 'attendance'" do
      it 'renders the :attendance_index view' do
        event = create(:event_with_registrations)

        get 'index', params: { event_id: event.id, view: 'attendance' }

        expect(response).to render_template :attendance_index
      end
    end
  end

  describe 'GET :show' do
    it 'assigns event to @event' do
      event = create(:event_with_registrations, registrations_count: 1)
      registration = event.registrations.first

      post :show, params: { event_id: event.to_param, id: registration.to_param }

      expect(assigns(:event)).to eq event
    end

    context "with params[:view] == 'attendance'" do
      it 'assigns the registration to @attendance' do
        event = create(:event_with_registrations, registrations_count: 1)
        registration = event.registrations.first

        post :show, params: { event_id: event.to_param, id: registration.to_param, view: 'attendance' }

        expect(assigns(:attendance)).to eq registration
      end
    end

    context "without params[:view] == 'attendance'" do
      it 'assigns the registration to @registration' do
        event = create(:event_with_registrations, registrations_count: 1)
        registration = event.registrations.first

        post :show, params: { event_id: event.to_param, id: registration.to_param, view: '' }

        expect(assigns(:registration)).to eq registration
      end
    end
  end
end
