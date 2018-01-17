require 'rails_helper'

describe Events::LocalitiesController, type: :controller do
  before(:example) do
    sign_in_user
  end

  describe 'GET :index' do
    it 'assigns all localities not participating in the event to @localities' do
      locality_names = create_list(:locality, 2).map(&:city)
      event = create(:event_with_registrations, registrations_count: 1)
      loc_with_registration = event.registrations.first.locality

      get :index, event_id: event.id

      expect(assigns(:localities).map(&:city)).to include(locality_names.first)
      expect(assigns(:localities).map(&:city)).to include(locality_names.second)
      expect(assigns(:localities).map(&:city)).to_not include(loc_with_registration)
    end

    it 'assigns all event localities to @event_localities' do
      event = create(:event_with_registrations, ensure_unique_locality: false)

      get :index, event_id: event.id

      expect(assigns(:event_localities)).to match_array(event.localities)
    end
  end

  describe 'POST :create' do
    context 'with valid params' do
      let(:event) do
        create(:event_with_registrations,
               ensure_unique_locality: false,
               registrations_count: 1)
      end
      let(:locality) { create(:locality) }
      before(:example) do
        post :create, event_id: event.id, locality_id: locality.id
      end

      it 'assigns event to @event' do
        expect(assigns(:event)).to eq event
      end

      it 'assigns locality to @locality' do
        expect(assigns(:locality)).to eq locality
      end

      it 'assings event_locality to @event_locality' do
        expect(assigns(:event_locality).event_id).to eq event.id
        expect(assigns(:event_locality).locality_id).to eq locality.id
      end

      it 'assings locality user ids to @locality_user_ids'
      it 'renders the events/localities index on save'

      it' displays a flash notice'
    end
  end
end
