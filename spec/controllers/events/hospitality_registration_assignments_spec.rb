require 'rails_helper'

describe Events::HospitalityRegistrationAssignmentsController, type: :controller do
  before(:example) do
    sign_in_user
  end

  describe 'GET :index' do
    it 'assigns the current event to @event' do
      event = create(:event)

      get :index, params: { event_id: event.id }
      expect(assigns(:event)).to eq event
    end

    it 'assigns event localities to @event_localities sorted asc' do
      event = create(:event)
      locality1 = create(:locality, city: 'Portstown')
      locality2 = create(:locality, city: 'Beantown')
      EventLocality.create(event: event, locality: locality1)
      EventLocality.create(event: event, locality: locality2)

      get :index, params: { event_id: event.id }

      sorted_city_names = EventLocality.all.map(&:locality).map(&:city).sort
      expect(assigns(:event_localities).map(&:locality).map(&:city))
        .to match_array(sorted_city_names)
    end

    it 'renders the :index template' do
      event = create(:event)

      get :index, params: { event_id: event.id }
      expect(response).to render_template(:index)
    end
  end

  describe 'GET :show' do
    it 'assigns the current event to @event' do
      event = create(:event)
      locality = create(:locality)

      get :show, params: { event_id: event.id, locality_id: locality.id }

      expect(assigns(:event)).to eq event
    end

    it 'assigns the current locality to @locality' do
      event = create(:event)
      locality = create(:locality)

      get :show, params: { event_id: event.id, locality_id: locality.id }

      expect(assigns(:locality)).to eq locality
    end

    it 'is :ok' do
      event = create(:event)
      locality = create(:locality)

      get :show, params: { event_id: event.id, locality_id: locality.id }

      expect(response).to have_http_status(:ok)
    end

    it 'renders the :show template' do
      event = create(:event)
      locality = create(:locality)

      get :show, params: { event_id: event.id, locality_id: locality.id }

      expect(response).to render_template(:show)
    end
  end

  describe 'POST :assign' do
    it 'assigns the current event to @event' do
      event = create(:event)
      locality = create(:locality)

      post :show, params: { event_id: event.id, locality_id: locality.id }

      expect(assigns(:event)).to eq event
    end

    it 'assigns the current locality to @locality' do
      event = create(:event)
      locality = create(:locality)

      post :show, params: { event_id: event.id, locality_id: locality.id }

      expect(assigns(:locality)).to eq locality
    end

    context 'Hospitality for a saint is selected' do
      it 'assigns the hospitality to the saint' do
        event = create(:event_with_registrations, ensure_unique_locality: true)
        locality = create(:locality)
        users = event.registrations.map(&:user)
        hospitality = create(:hospitality, event: event, lodging: create(:lodging))
        saint_hospitality_ids = { users.first.to_param => [hospitality.id] }
        registration = event.registrations.first

        post :assign,
             params: { event_id: event.id,
                       locality_id: locality.id,
                       saint_hospitality_ids: saint_hospitality_ids }
        registration.reload

        expect(registration.hospitality).to eq hospitality
        expect(HospitalityRegistrationAssignment
          .where(registration: registration).first.registration).to eq registration
      end

      it 'is successful' do
        event = create(:event_with_registrations, ensure_unique_locality: true)
        locality = create(:locality)
        users = event.registrations.map(&:user)
        hospitality = create(:hospitality, event: event, lodging: create(:lodging))
        saint_hospitality_ids = { users.first.to_param => [hospitality.id] }

        post :assign,
             params: { event_id: event.id,
                       locality_id: locality.id,
                       saint_hospitality_ids: saint_hospitality_ids }

        expect(response).to have_http_status(:redirect)
      end

      it 'redirects to the hospitality_registration_assignments#index' do
        event = create(:event_with_registrations, ensure_unique_locality: true)
        locality = create(:locality)
        users = event.registrations.map(&:user)
        hospitality = create(:hospitality, event: event, lodging: create(:lodging))
        saint_hospitality_ids = { users.first.to_param => [hospitality.id] }

        post :assign,
             params: { event_id: event.id,
                       locality_id: locality.id,
                       saint_hospitality_ids: saint_hospitality_ids }

        expect(response)
          .to redirect_to(event_hospitality_registration_assignments_path(event))
      end
    end

    context 'Hospitality for a saint is unselected' do
      it "it removes the hospitality assignment from the saint's registration" do
        event = create(:event_with_registrations, ensure_unique_locality: true)
        locality = create(:locality)
        hospitality = create(:hospitality, event: event, lodging: create(:lodging))
        registration = event.registrations.first
        registration.update_attributes(hospitality: hospitality)
        HospitalityRegistrationAssignment
          .create(hospitality: hospitality,
                  registration: registration,
                  locality: locality,
                  event: event)
        saint_hospitality_ids = { registration.user.to_param => [''] }

        post :assign,
             params: { event_id: event.id,
                       locality_id: locality.id,
                       saint_hospitality_ids: saint_hospitality_ids }

        registration.reload

        expect(registration.hospitality).to be_nil
        expect(HospitalityRegistrationAssignment
          .where(registration: registration)).to be_empty
      end

      it 'is success' do
        event = create(:event_with_registrations, ensure_unique_locality: true)
        locality = create(:locality)
        hospitality = create(:hospitality, event: event, lodging: create(:lodging))
        users = event.registrations.map(&:user)
        saint_hospitality_ids = { users.first.to_param => [hospitality.id] }

        post :assign,
             params: { event_id: event.id,
                       locality_id: locality.id,
                       saint_hospitality_ids: saint_hospitality_ids }

        expect(response).to have_http_status(:redirect)
      end

      it 'redirects to the hospitality_registration_assignments#index' do
        event = create(:event_with_registrations, ensure_unique_locality: true)
        locality = create(:locality)
        hospitality = create(:hospitality, event: event, lodging: create(:lodging))
        users = event.registrations.map(&:user)
        saint_hospitality_ids = { users.first.to_param => [hospitality.id] }

        post :assign,
             params: { event_id: event.id,
                       locality_id: locality.id,
                       saint_hospitality_ids: saint_hospitality_ids }

        expect(response)
          .to redirect_to(event_hospitality_registration_assignments_path(event))
      end
    end
  end
end
