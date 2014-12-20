class Events::HospitalityLocalityAssignmentsController < ApplicationController
  def index
    @event = Event.find(params[:event_id])
    @stats =  @event.load_locality_summary
  end

  def assign
    binding.pry
    @event = Event.find(params[:event_id])
    Locality.find(params[:hospitality_locality_ids]).each do |loc| 
    end
  end
end
