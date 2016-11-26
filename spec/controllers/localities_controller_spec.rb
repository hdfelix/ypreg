require 'rails_helper'

describe LocalitiesController, type: :controller do
  before(:example) do
    sign_in_user
  end

  describe 'GET :index' do
    it 'assigns all localities' do
      localities = create_list(:locality, 2)
      get :index
      expect(assigns(:localities)).to match_array(localities)
    end

    it 'is a success' do
      get :index
      expect(response).to have_http_status(:ok)
    end

    it 'renders the :index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET :show' do
    it 'assigns the requested locality to @locality' do
      locality = create(:locality)
      get :show, id: locality.to_param
      expect(assigns(:locality)).to eq(locality)
    end

    it 'renders the :show template' do
      get :show, id: create(:locality)
      expect(response).to render_template :show
    end
  end

  describe 'GET :new' do
    it 'instantiates a new @locality' do
      get :new, {}
      expect(assigns(:locality)).to be_a_new(Locality)
    end

    it 'render the :new template' do
      get :new, {}
      expect(response).to render_template(:new)
    end
  end

  describe 'POST :create' do
    context 'with valid params' do
      it 'creates a new locality' do
        expect {
          post :create, locality: attributes_for(:locality)
        }.to change(Locality, :count).by(1)
      end

      it 'assigns a newly created locality as @locality' do
        post :create, locality: attributes_for(:locality)
        expect(assigns(:locality)).to be_a(Locality)
        expect(assigns(:locality)).to be_persisted
      end

      it 'redirects to :index' do
        post :create, locality: attributes_for(:locality)
        expect(response).to redirect_to localities_path
      end
    end

    context 'with invalid params' do
      before(:example) do
        allow_any_instance_of(Locality).to receive(:save).and_return(false)
      end

      it 'assigns a newly created but unsaved locality as @locality' do
        post :create, locality: { city: '' }
        expect(Locality.all.count).to eq(0)
        expect(assigns(:locality)).to be_a_new(Locality)
      end

      it 're-renders the :new template' do
        post :create, locality: { city: '' }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET :edit' do
    before(:example) do
      @locality = create(:locality)
    end

    it 'assigns the requested locality as @locality' do
      get :edit, id: @locality.to_param
      expect(assigns(:locality)).to eq(@locality)
    end

    it 'render the :edit template' do
      get :edit, id: @locality.to_param
      expect(response).to render_template(:edit)
    end
  end
  describe 'PUT update'
  describe 'DELETE destroy'
end
