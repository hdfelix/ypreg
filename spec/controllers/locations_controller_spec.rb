require 'rails_helper'

describe LocationsController, type: :controller do
  before(:example) do
    sign_in_user(double('user', role?: 'admin'))
  end

  describe 'GET index' do
    it 'assigns all locations' do
      locations = create_list(:location, 2)
      get :index
      expect(assigns(:locations)).to match_array(locations)
    end

    it 'is a success' do
      get :index
      expect(response).to have_http_status(:ok)
    end

    it "renders the 'index' template" do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET show' do
    it 'assigns the requested location to @location' do
      location = create(:location)

      get :show, id: location.to_param

      expect(assigns(:location)).to eq(location)
    end
  end

  describe 'GET new' do
    it 'assigns a new location as @location' do
      get :new, {}
      expect(assigns(:location)).to be_a_new(Location)
    end
  end

  describe 'GET edit' do
    it 'assigns the requested location as @location' do
      location = create(:location)

      get :edit, id: location.to_param

      expect(assigns(:location)).to eq(location)
    end
  end

  describe 'POST create' do
    context 'with valid params' do
      it 'create a new location' do
        expect {
          post :create, location: attributes_for(:location)
        }.to change(Location, :count).by(1)
      end

      it 'assigns a newly created location as @location' do
        post :create, location: attributes_for(:location)

        expect(assigns(:location)).to be_a(Location)
        expect(assigns(:location)).to be_persisted
      end

      it 'redirects to the location index' do
        post :create, location: attributes_for(:location)
        expect(response).to redirect_to locations_path
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved location as @location' do
        Location.any_instance.stub(:save).and_return(false)
        post :create, location: { name: '' }
        expect(assigns(:location)).to be_a_new(Location)
      end

      it "re-renders the 'new' template" do
        Location.any_instance.stub(:save).and_return(false)
        post :create, location: { name: '' }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PUT update'
  describe 'DELETE destroy'
end
