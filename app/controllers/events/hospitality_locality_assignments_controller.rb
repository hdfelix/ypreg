class Events::HospitalityLocalityAssignmentsController < ApplicationController
  def index
    binding.pry
    @event = Event.find(params[:event_id])
    @stats =  @event.load_locality_summary
  end

  def assign
    @event = Event.find(params[:event_id])
    hospitality_ids = params[:hospitality_locality_ids].keys
    # locality_ids = params[:hospitality_locality_ids].values

    hospitality_ids.each do |id|
      binding.pry
      hosp = @event.hospitalities.find(id)
      loc = params[:hospitality_locality_ids][id.to_sym][0]
      loc = loc.to_i unless (loc.nil? || loc.empty?)
      hosp.update_attributes(locality_id: loc)
    end
    @event.save
    redirect_to  event_hospitality_locality_assignments_path
  end
end
