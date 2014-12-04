require 'rails_helper'

describe LodgingsController, type: :controller do

  describe "GET 'index'" do
    it 'lists all @lodgings' do
      Lodging.delete_all  # TODO: Why am I seeing Lodgings before this call?
      h1 = create(:lodging)
      h2 = create(:lodging)
      get 'index'
      expect(assigns(:lodgings)).to match_array([h1, h2])
    end
  end

  describe "GET 'show'" do
    it 'assignes the requested lodging to @lodging' do
      lodging = create(:lodging)
      get :show, id: lodging
      expect(assigns(:lodging)).to eq lodging
    end

    # it 'renders the :show template' do
    #   get :show, id: create(:lodging)
    #   expect(response).to render_template :show
    # end
  end

  describe "GET 'new'" do
    it 'instantiates a new @lodging' do
      get :new
      expect(assigns(:lodging)).to be_a_new(Lodging)
    end

    # it "renders the :new template" do
    #   get :new
    #   expect(response).to render_template :new
    # end
  end
end
