class Events::EventLodgingLocalityAssignmentsController < ApplicationController
  def index
    @event = Event.find(params[:event_id])
    @stats = @event.load_locality_summary
  end

  def assign
    @event = Event.find(params[:event_id])
    event_lodging_ids = params[:event_lodging_locality_ids].keys

    event_lodging_ids.each do |id|
      hosp = @event.event_lodgings.find(id)
      loc = params[:event_lodging_locality_ids][id.to_sym][0]
      # TODO: factor out to service EventLodgingLocalityManager
      if loc.empty?
        loc = nil
      else
        loc = loc.to_i
      end
      # TODO: should this be an array?
      hosp.update_attributes(locality_id: loc)
    end
    @event.save
    redirect_to event_event_lodging_locality_assignments_path
  end
end
