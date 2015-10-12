require 'rails_helper'
require 'awesome_print'

describe Events::CopiesController, type: :controller do
  describe 'POST :create' do
    context 'with a valid params[:event_id]' do
      before(:example) do
        @event = create(:event)
      end
      context 'with no errors on @event' do
        it 'create a new (copied) event' do
          expect do
            post :create, event_id: @event.id
          end.to change(Event, :count).by(1)
        end

        it 'sets a success flash notice' do
          post :create, event_id: @event.id
          expect(flash[:notice]).to eq 'Event copied successfully.'
        end

        it 'redirects to the event copy @event' do
          post :create, event_id: @event.id
          expect(response).to redirect_to event_path Event.all.second
        end
      end
    end
  end
end
