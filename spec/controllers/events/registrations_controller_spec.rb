require 'rails_helper'

describe Events::RegistrationsController, type: :controller do
  let (:event) { create(:event_with_registrations) }
  before(:example) do
    sign_in_user(double('user', role?: 'admin'))
  end

  describe 'GET #index' do
    it 'assigns event to @event' do
      get :index, event_id: event.to_param
      expect(assigns(:event)).to eq event
    end

    it 'assigns event registrations to @registrations' do
      get :index, event_id: event.to_param
      event.registrations.sort_by { |reg| reg.locality.city }
      expect(assigns(:registrations).map(&:id))
        .to eq event.registrations.map(&:id)
    end

    it 'is :ok' do
      get :index, event_id: event.to_param
      expect(response).to have_http_status(:ok)
    end

    context "without params[:view] == 'attendance'" do
      it 'renders the :index view' do
        get :index, event_id: event.id
        expect(response).to render_template :index
      end
    end

    context "with params[:view] == 'attendance'" do
      it 'renders the :attendance_index view' do
        event = create(:event_with_registrations)

        get 'index', event_id: event.id, view: 'attendance'

        expect(response).to render_template :attendance_index
      end
    end
  end

  describe 'GET :show' do
    it 'assigns event to @event' do
      post :show, event_id: event.to_param
      expect(assigns(:event)).to eq event
    end

    context "with params[:view] == 'attendance'" do
      it 'assigns the registration to @attendance' do
      end
    end

    context "without params[:view] == 'attendance'" do
      it 'assigns the registration to @registration' do
        ev = create(:event_with_registrations, registrations_count: 1)
        registration = ev.registrations.first
        post :show, event_id: event.to_param, id: registration.to_param
        expect(assigns(:registration)).to eq registration
      end
    end
  end
end
