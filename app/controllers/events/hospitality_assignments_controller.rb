class Events::HospitalityAssignmentsController < ApplicationController
  def index
    @event = Event.find(params[:event_id])
    @stats =  @event.load_locality_summary
  end
end
