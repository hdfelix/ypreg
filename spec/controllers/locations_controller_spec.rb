require 'spec_helper'

describe LocationsController do
  
  # This should return the minimal set of attributes required to create a valid
  # Location. As you add validations to Location, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { title:"",description:"",address_id: '' } }
  # TODO: Test valid session let(:valid_session) { {} }
	#       pass :valid_session to 'get'

	describe "GET index" do
    it "assigns all locations as @locations" do
			location = create(:location)
      get :index
      expect(assigns(:locations)).to eq([location])
    end

		it "renders the :index view" do
			get :index
			expect(response).to render_template :index
		end
  end

  describe "GET show" do
    it "assigns the requested location as @location" do
      location = create(:location) 
      get :show, id: location
      expect(assigns(:location)).to eq location
    end

		it "renders the :show template" do
			location = create(:location)
			get :show, id: location
			expect(response).to render_template :show
		end
  end

  describe "GET new" do
    it "assigns a new location as @location" do
      get :new
      expect(assigns(:location)).to be_a_new(Location)
    end

		it "renders the :new template" do
			get :new
			expect(response).to render_template :new
		end

  end

  describe "GET edit" do
    it "assigns the requested location as @location" do
      location = create(:location)
      get :edit, {id: location.to_param}#, valid_session
			expect(assigns(:location)).to eq(location)
    end

		it "renders the :edit template" do
			location = create(:location)
			get :edit, id: location
			expect(response).to render_template :edit
		end	
  end

  describe "POST create" do
  #  #describe "with valid params" do
  #    it "creates a new Location" do
  #      expect {post :create, {location: valid_attributes}}.to change(Location, :count).by(1)
  #    end

  #    it "assigns a newly created location as @location" do
  #      post :create, {location: valid_attributes}#, valid_session
  #      assigns(:location).should be_a(Location)
  #      assigns(:location).should be_persisted
  #    end

  #    it "redirects to the created location" do
  #      post :create, {location: valid_attributes}#, valid_session
  #      response.should redirect_to(Location.last)
  #    end
			#end #end 'with valid params'
#
#    describe "with invalid params" do
#      it "assigns a newly created but unsaved location as @location" do
#        # Trigger the behavior that occurs when invalid params are submitted
#        Location.any_instance.stub(:save).and_return(false)
#        post :create, {:location => { "name" => "invalid value" }}, valid_session
			#        
#        assigns(:location).should be_a_new(Location)
#      end
#
#      it "re-renders the 'new' template" do
#        # Trigger the behavior that occurs when invalid params are submitted
#        Location.any_instance.stub(:save).and_return(false)
#        post :create, {:location => { "name" => "invalid value" }}, valid_session
#        response.should render_template("new")
#      end
    #end
  end
#
#  describe "PUT update" do
#    describe "with valid params" do
#      it "updates the requested location" do
#        location = Location.create! valid_attributes
#        # Assuming there are no other locations in the database, this
#        # specifies that the Location created on the previous line
#        # receives the :update_attributes message with whatever params are
#        # submitted in the request.
#        Location.any_instance.should_receive(:update).with({ "name" => "MyString" })
#        put :update, {:id => location.to_param, :location => { "name" => "MyString" }}, valid_session
#      end
#
#      it "assigns the requested location as @location" do
#        location = Location.create! valid_attributes
#        put :update, {:id => location.to_param, :location => valid_attributes}, valid_session
#        assigns(:location).should eq(location)
#      end
#
#      it "redirects to the location" do
#        location = Location.create! valid_attributes
#        put :update, {:id => location.to_param, :location => valid_attributes}, valid_session
#        response.should redirect_to(location)
#      end
#    end
#
#    describe "with invalid params" do
#      it "assigns the location as @location" do
#        location = Location.create! valid_attributes
#        # Trigger the behavior that occurs when invalid params are submitted
#        Location.any_instance.stub(:save).and_return(false)
#        put :update, {:id => location.to_param, :location => { "name" => "invalid value" }}, valid_session
#        assigns(:location).should eq(location)
#      end
#
#      it "re-renders the 'edit' template" do
#        location = Location.create! valid_attributes
#        # Trigger the behavior that occurs when invalid params are submitted
#        Location.any_instance.stub(:save).and_return(false)
#        put :update, {:id => location.to_param, :location => { "name" => "invalid value" }}, valid_session
#        response.should render_template("edit")
#      end
#    end
#  end
#
#  describe "DELETE destroy" do
#    it "destroys the requested location" do
#      location = Location.create! valid_attributes
#      expect {
#        delete :destroy, {:id => location.to_param}, valid_session
#      }.to change(Location, :count).by(-1)
#    end
#
#    it "redirects to the locations list" do
#      location = Location.create! valid_attributes
#      delete :destroy, {:id => location.to_param}, valid_session
#      response.should redirect_to(locations_url)
#    end
#  end

end
