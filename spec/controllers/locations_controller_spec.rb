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
    context 'with valid params'
    context 'with invalid params'
  end

  describe 'PUT update'
  describe 'DELETE destroy'
end
