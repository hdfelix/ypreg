class Events::HospitalityAssignmentsController < ApplicationController
  def index
    @event = Event.find(params[:event_id])
    @stats =  @event.load_locality_summary
    @assigned_hospitalities = @event.assigned_hospitalities
    @unassigned_hospitalities = @event.unassigned_hospitalities
  end
end
