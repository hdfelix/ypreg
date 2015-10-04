require 'rails_helper'

describe Events::HospitalityRegistrationAssignmentsController, type: :controller do
  let (:event) { create(:event) }
  before(:example) do
    sign_in_user(double(:user, role?: 'admin'))
  end

  describe 'GET :index' do
    it 'assigns the current event to @event' do
      get :index, event_id: event.id
      expect(assigns(:event)).to eq event
    end

    it 'assigns event localities to @event_localities sorted asc' do
      locality_1 = create(:locality, city: 'Portstown')
      locality_2 = create(:locality, city: 'Beantown')
      EventLocality.create(event: event, locality: locality_1)
      EventLocality.create(event: event, locality: locality_2)

      get :index, event_id: event.id

      sorted_city_names = EventLocality.all.map(&:locality).map(&:city).sort
      expect(assigns(:event_localities).map(&:locality).map(&:city))
        .to match_array(sorted_city_names)
    end

    it 'renders the :index template' do
      get :index, event_id: event.id
      expect(response).to render_template(:index)
    end
  end

  describe 'GET :show' do
    let (:locality) { create(:locality) }

    it 'assigns the current event to @event' do
      get :show, event_id: event.id, locality_id: locality.id
      expect(assigns(:event)).to eq event
    end

    it 'assigns the current locality to @locality' do
      get :show, event_id: event.id, locality_id: locality.id
      expect(assigns(:locality)).to eq locality
    end

    it 'is :ok' do
      get :show, event_id: event.id, locality_id: locality.id
      expect(response).to have_http_status(:ok)
    end

    it 'renders the :show template' do
      get :show, event_id: event.id, locality_id: locality.id
      expect(response).to render_template(:show)
    end
  end

  describe 'POST :assign' do
    let (:locality) { create(:locality) }

    it 'assigns the current event to @event' do
      post :show, event_id: event.id, locality_id: locality.id
      expect(assigns(:event)).to eq event
    end

    it 'assigns the current locality to @locality' do
      post :show, event_id: event.id, locality_id: locality.id
      expect(assigns(:locality)).to eq locality
    end

    let (:event) { create(:event_with_registrations, ensure_unique_locality: true) }
    let (:users) { event.registrations.map(&:user) }
    let (:saint_hospitality_ids) { { users.first.to_param => [''] } }
    let (:hospitality) do
      create(:hospitality, event: event, lodging: create(:lodging))
    end

    context 'Hospitality for a saint is selected' do
      it 'assigns the hospitality to the saint' do
        saint_hospitality_ids = { users.first.to_param => [hospitality.id] }
        registration = event.registrations.first

        post :assign,
             event_id: event.id,
             locality_id: locality.id,
             saint_hospitality_ids: saint_hospitality_ids

        registration.reload
        expect(registration.hospitality).to eq hospitality
        expect(HospitalityRegistrationAssignment
          .where(registration: registration).first.registration).to eq registration
      end

      it 'is successful' do
        post :assign,
             event_id: event.id,
             locality_id: locality.id,
             saint_hospitality_ids: saint_hospitality_ids

        expect(response).to have_http_status(:redirect)
      end

      it 'redirects to the hospitality_registration_assignments#index' do
        post :assign,
             event_id: event.id,
             locality_id: locality.id,
             saint_hospitality_ids: saint_hospitality_ids

        expect(response)
          .to redirect_to(event_hospitality_registration_assignments_path(event))
      end
    end

    context 'Hospitality for a saint is unselected' do
      it "it removes the hospitality assignment from the saint's registration" do
        registration = event.registrations.first
        registration.update_attributes(hospitality: hospitality)
        HospitalityRegistrationAssignment
          .create(hospitality: hospitality,
                  registration: registration,
                  locality: locality)
        saint_hospitality_ids = { users.first.to_param => [''] }

        post :assign,
             event_id: event.id,
             locality_id: locality.id,
             saint_hospitality_ids: saint_hospitality_ids

        registration.reload
        expect(registration.hospitality).to be_nil
        expect(HospitalityRegistrationAssignment
          .where(registration: registration)).to be_empty
      end

      it 'is success' do
        post :assign,
             event_id: event.id,
             locality_id: locality.id,
             saint_hospitality_ids: saint_hospitality_ids

        expect(response).to have_http_status(:redirect)
      end

      it 'redirects to the hospitality_registration_assignments#index' do
        post :assign,
             event_id: event.id,
             locality_id: locality.id,
             saint_hospitality_ids: saint_hospitality_ids

        expect(response)
          .to redirect_to(event_hospitality_registration_assignments_path(event))
      end
    end
  end
end
