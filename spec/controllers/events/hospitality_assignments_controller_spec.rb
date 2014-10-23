require 'rails_helper'

describe Events::HospitalityAssignmentsController, :type => :controller do
  # let(:valid_attributes) { { "lodging_id" => "", "locality_id" => "" } }

  describe "POST assign_lodging_to_locality" do
    it "assigns a lodging unit to a locality" do
      @event = create(:event)
      @lodging = create(:lodging)
      @locality = create(:locality)

      pending 'Write this test'
      
    end
  end
end
