require 'rails_helper'

describe Events::HospitalityLocalityAssignmentsController, type: :controller do
  let (:event) { create(:event) }
  before(:example) do
    sign_in_user(double('user', role?: 'admin'))
  end

  describe 'GET :index' do
    it 'assigns the current event to @event' do
      get :index, event_id: event.id
      expect(assigns(:event)).to eq event
    end

    it 'assigns event stats to @stats' do
      event = create(:event)
      get :index, event_id: event.id
      expect(assigns(:stats)).to eq event.load_locality_summary
    end

    it 'is success' do
      get :index, event_id: event.id
      expect(response).to have_http_status(:ok)
    end

    it 'renders the :index template' do
      get :index, event_id: event.id
      expect(response).to render_template(:index)
    end
  end

  describe 'POST assign' do
    context 'with hospitality_locality_ids' do
      it 'assigns the current event to @event' do
        get :index, event_id: event.id
        expect(assigns(:event)).to eq event
      end

      it 'updates hospitality with a locality id' do
        event = create(:event_with_registrations, ensure_unique_locality: true)
        hospitalities, localities = [], []
        event.registrations.each do |reg|
          localities << reg.locality
          hospitalities << create(:hospitality,
                                  event: event,
                                  registration: reg,
                                  locality: reg.locality)
        end

        ids_hash = {}
        ids_hash[hospitalities.first.id.to_s] = [localities.first.id.to_s]
        ids_hash[hospitalities.second.id.to_s] = [localities.second.id.to_s]

        post :assign, event_id: event.id, hospitality_locality_ids: ids_hash

        expect(event.hospitalities.first.locality.id).to eq localities.first.id
      end
    end

    context ' without hospitality_locality_ids'
  end
end
