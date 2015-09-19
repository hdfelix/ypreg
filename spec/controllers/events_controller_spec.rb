require 'rails_helper'

describe EventsController, type: :controller do
  before(:example) do
    sign_in_user(double('user', role?: 'admin'))
  end

  describe 'GET :index' do
    it 'assigns all events and past_events' do
      now = Time.zone.now
      event_over =
        create(:event, begin_date: 1.month.ago, end_date: 1.month.ago + 2.days)
      event_not_over =
        create(:event, begin_date: now + 8.days, end_date: now + 10.days)

      get :index

      expect(assigns(:events)).to match_array([event_not_over])
      expect(assigns(:past_events)).to match_array([event_over])
    end

    it 'is a success' do
      get :index
      expect(response).to have_http_status(:ok)
    end

    it "renders 'index' template" do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET show' do
    it "assigns the requested event to @event and \
        localities participating to @participating_localities" do
      event = create(:event_with_registrations)
      participating_localities =
        event.participating_localities.sort { |a, b| a.city <=> b.city }
      stats = event.load_locality_summary

      get :show, id: event.to_param

      expect(assigns(:event)).to eq(event)
      expect(assigns(:participating_localities)).to eq(participating_localities)
      expect(assigns(:stats)).to eq(stats)
    end
  end

  describe 'GET :new' do
    it 'assigns a new event as @event' do
      get :new, {}
      expect(assigns(:event)).to be_a_new(Event)
    end
  end

  describe 'GET :edit' do
    it 'assigns the requested event as @event' do
      event = create(:event)

      get :edit, id: event.to_param

      expect(assigns(:event)).to eq(event)
    end
  end

  describe 'POST :create' do
    describe 'with valid params' do
      it 'creates a new Event' do
        expect {
          post :create, event: attributes_for(:event).merge(location_id: 1)
        }.to change(Event, :count).by(1)
      end

      it 'assigns a newly created event as @event' do
        post :create, event: attributes_for(:event).merge(location_id: 1)

        expect(assigns(:event)).to be_an(Event)
        expect(assigns(:event)).to be_persisted
      end

      it 'redirects to the event index' do
        post :create, event: attributes_for(:event).merge(location_id: 1)
        expect(response).to redirect_to events_path
      end
    end

    describe 'with invalid params' do
      before(:example) do
        allow_any_instance_of(Event).to receive(:save).and_return(false)
      end
      it 'assigns a newly created but unsaved event as @event' do
        post :create, event: { title: '' }
        expect(assigns(:event)).to be_a_new(Event)
      end

      it "re-renders the 'new' template" do
        post :create, event: { title: '' }
        expect(response).to render_template(:new)
      end
    end
  end

  # describe "PUT update" do
  #   describe "with valid params" do
  #     it "updates the requested event" do
  #       event = create(:event)
  #       Event.any_instance.should_receive(:update).with({ title: "New Title" })
  #       put :update, { id: event.to_param, event: { title: "New Title" }}
  #     end

  #     it "assigns the requested event as @event" do
  #       event = create(:event)
  #       put :update, { event: event }
  #       expect(assigns(:event)).to eq(event)
  #     end

  #     it "redirects to the event" do
  #       event = Event.create! valid_attributes
  #       put :update, {:id => event.to_param, :event => valid_attributes}, valid_session
  #       response.should redirect_to(event)
  #     end
  #   end

  #   describe "with invalid params" do
  #     it "assigns the event as @event" do
  #       event = Event.create! valid_attributes
  #       # Trigger the behavior that occurs when invalid params are submitted
  #       Event.any_instance.stub(:save).and_return(false)
  #       put :update, {:id => event.to_param, :event => { "title" => "invalid value" }}, valid_session
  #       assigns(:event).should eq(event)
  #     end

  #     it "re-renders the 'edit' template" do
  #       event = Event.create! valid_attributes
  #       # Trigger the behavior that occurs when invalid params are submitted
  #       Event.any_instance.stub(:save).and_return(false)
  #       put :update, {:id => event.to_param, :event => { "title" => "invalid value" }}, valid_session
  #       response.should render_template("edit")
  #     end
  #   end
  # end

  #describe "DELETE destroy" do
  #  it "destroys the requested event" do
  #    event = Event.create! valid_attributes
  #    expect {
  #      delete :destroy, {:id => event.to_param}, valid_session
  #    }.to change(Event, :count).by(-1)
  #  end

  #  it "redirects to the events list" do
  #    event = Event.create! valid_attributes
  #    delete :destroy, {:id => event.to_param}, valid_session
  #    response.should redirect_to(events_url)
  #  end
  #end
end
