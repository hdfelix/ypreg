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

    it 'assigns unassigned lodgings providing hospitality for the event \
        to @lodgings' do
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

  describe 'POST add' do
    it 'assigns all the current event to @event' do
      get :index, event_id: event.id
      expect(assigns(:event)).to eq event
    end

    context 'with valid at least one lodging id' do
      before(:example) do
        2.times { |t| create(:lodging, id: t) }
        post :add, event_id: event.id, lodging_ids: [0, 1]
      end

      it 'creates a hospitality for @event from each lodging id' do
        expect(event.hospitalities.count).to eq 2
      end

      it 'redirects to Event#show for @event' do
        expect(response).to redirect_to event_path(event)
      end

      it 'sets a success flash notice' do
        expect(flash[:notice]).to eq 'Hospitalities added successfully.'
      end
    end

    context 'with no lodging ids' do
      before(:example) do
        2.times { |t| create(:lodging, id: t) }
        post :add, event_id: event.id, lodging_ids: nil
      end

      it 'redirects to the event hospitalities index' do
        expect(response).to redirect_to event_hospitalities_path(event)
      end

      it 'sets a flash error notice' do
        expect(flash[:error]).to eq 'No lodgings selected.'
      end
    end
  end

  describe 'PUT remove' do
    context 'with lodging ids' do
      it 'assigns all the current event to @event' do
        get :index, event_id: event.id
        expect(assigns(:event)).to eq event
      end

      it 'destroys all the selected event hospitalities' do
        2.times do
          hosp = create(:hospitality, event: event)
          event.hospitalities << hosp
        end
        lodging_ids = event.hospitalities.map(&:lodging_id)
        event.save

        put :remove, event_id: event.id, hospitality_lodging_ids: lodging_ids

        expect(event.hospitalities.count).to eq 0
      end

      it 'redirects to Event#show' do
        2.times do
          hosp = create(:hospitality, event: event)
          event.hospitalities << hosp
        end
        lodging_ids = event.hospitalities.map(&:lodging_id)
        event.save

        put :remove, event_id: event.id, hospitality_lodging_ids: lodging_ids

        expect(response).to redirect_to(event)
      end
    end

    context 'without lodging ids' do
      before(:example) do
        put :remove, event_id: event.id, hospitality_lodging_ids: nil
      end

      it 'redirects to event hospitalities index' do
        expect(response).to redirect_to event_hospitalities_path(event)
      end

      it 'sets a flash error notice' do
        expect(flash[:error]).to eq 'No hospitalities selected.'
      end
    end
  end
end
