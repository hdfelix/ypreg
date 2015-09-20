require 'rails_helper'

describe LodgingsController, type: :controller do
  before(:example) do
    sign_in_user(double('user', role?: 'admin'))
  end

  describe 'GET :index' do
    it 'lists all @lodgings' do
      h1 = create(:lodging)
      h2 = create(:lodging)

      get 'index'

      expect(assigns(:lodgings)).to match_array([h1, h2])
    end

    it 'is a success' do
      get :index
      expect(response).to have_http_status(:ok)
    end

    it 'renders :index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET :show' do
    it 'assigns the requested lodging to @lodging' do
      lodging = create(:lodging)

      get :show, id: lodging.to_param

      expect(assigns(:lodging)).to eq lodging
    end

    it 'renders the :show template' do
      get :show, id: create(:lodging)
      expect(response).to render_template :show
    end
  end

  describe 'GET :new' do
    it 'instantiates a new @lodging' do
      get :new
      expect(assigns(:lodging)).to be_a_new(Lodging)
    end

    it 'renders the :new template' do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'GET :edit' do
    it 'assigns the requested lodging as @lodging' do
      lodging = create(:lodging)

      get :edit, id: lodging.to_param

      expect(assigns(:lodging)).to eq(lodging)
    end

    it 'renders the :edit template' do
      get :edit, id: create(:lodging).to_param
      expect(response).to render_template(:edit)
    end
  end

  describe 'POST :create' do
    context 'with empty contact_person_id' do
      it 'create a new lodging' do
        expect {
          post :create, lodging: attributes_for(:lodging)
        }.to change(Lodging, :count).by(1)
      end
    end
    context 'with valid params' do
      it 'create a new lodging' do
        expect {
          post :create, lodging: attributes_for(:lodging)
        }.to change(Lodging, :count).by(1)
      end

      it 'assigns a newly created lodging as @lodging' do
        post :create, lodging: attributes_for(:lodging)

        expect(assigns(:lodging)).to be_a(Lodging)
        expect(assigns(:lodging)).to be_persisted
      end

      it 'redirects to the lodging index' do
        post :create, lodging: attributes_for(:lodging)
        expect(response).to redirect_to lodgings_path
      end
    end

    context 'with invalid params' do
      before(:example) do
        allow_any_instance_of(Lodging).to receive(:save).and_return(false)
        @user = build_stubbed(:user)
        allow(User).to receive(:find).and_return(@user)
      end

      it 'assigns a newly created but unsaved lodging as @lodging' do
        post :create, lodging: { name: '', contact_person: @user }
        expect(assigns(:lodging)).to be_a_new(Lodging)
      end

      it 're-renders :new template' do
        post :create, lodging: { name: '', contact_person: @user }
        expect(response).to render_template(:new)
      end
    end
  end
end
