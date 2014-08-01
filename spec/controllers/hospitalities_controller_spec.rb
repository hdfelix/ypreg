require 'rails_helper'

describe HospitalitiesController, :type => :controller do

  describe "GET 'index'" do
    it 'it lists all @hospitalities' do
      h1 = create(:hospitality)
      h2 = create(:hospitality)
      get 'index'
      expect(assigns(:hospitalities)).to match_array([h1,h2]) 
    end
  end

  describe "GET 'show'" do
    it 'assignes the requested hospitality to @hospitality' do
      hospitality = create(:hospitality)
      get :show, id: hospitality
      expect(assigns(:hospitality)).to eq hospitality 
    end
    it 'renders the :show template' do
      hospitality = FactoryGirl.create(:hospitality)
      get :show, id: hospitality 
      expect(response).to render_template :show
    end 
  end

  describe "GET 'new'" do
     it "instantiates a new @hospitality" do
      get :new
      expect(assigns(:hospitality)).to be_a_new(Hospitality)
    end

    it "renders the :new template" do
      get :new
      expect(response).to render_template :new
    end 
  end
end
