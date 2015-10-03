require 'rails_helper'

describe Events::RegistrationsController, type: :controller do
  before(:example) do
    sign_in_user(double('user', role?:'admin'))
  end
 
  describe "GET #index" do 
    context "without params[:view] == 'attendance'" do
      it 'renders the :index view' do
        event = create(:event_with_registrations)
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
end
