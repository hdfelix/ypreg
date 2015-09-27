class Events::HospitalityLocalityAssignmentsController < ApplicationController
  def index
    @event = Event.find(params[:event_id])
    @stats = @event.load_locality_summary
  end

  def assign
    @event = Event.find(params[:event_id])
    hospitality_ids = params[:hospitality_locality_ids].keys

    hospitality_ids.each do |id|
      hosp = @event.hospitalities.find(id)
      loc = params[:hospitality_locality_ids][id.to_sym][0]
      if loc.empty?
        loc = nil
      else
        loc = loc.to_i
      end
      # TODO: should this be an array?
      hosp.update_attributes(locality_id: loc)
    end
    @event.save
    redirect_to event_hospitality_locality_assignments_path
  end
end
