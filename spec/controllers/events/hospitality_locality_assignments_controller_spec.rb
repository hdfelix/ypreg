require 'rails_helper'

describe Events::HospitalityLocalityAssignmentsController, type: :controller do
  let (:event) { create(:event) }
  before(:example) do
    sign_in_user
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

      it 'updates hospitality with a locality id and /
          redirects to :index' do
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
        expect(response).to redirect_to(event_hospitality_locality_assignments_path)
      end
    end

    context 'without hospitality_locality_ids' do
      context 'a previously assigned locality' do
        it 'is unassigned from the hospitality and /
            renders the :index template' do
          event = create(:event)
          localities = create_list(:locality, 2)
          localities.each do |loc|
            event.hospitalities <<
              create(:hospitality, event: event, locality: loc)
          end

          ids_hash = {}
          event.hospitalities.each do |hosp|
            ids_hash[hosp.id.to_s] = ['']
          end

          post :assign, event_id: event.id, hospitality_locality_ids: ids_hash
          event.reload

          expect(event.hospitalities.first.locality).to be_nil
          expect(event.hospitalities.second.locality).to be_nil
          expect(response).to redirect_to(event_hospitality_locality_assignments_path)
        end
      end
    end
  end
end
