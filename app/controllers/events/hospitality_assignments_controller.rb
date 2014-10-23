class Events::HospitalityAssignmentsController < ApplicationController
  skip_filter :verify_authenticity_token, :action
  respond_to :html, :js

  def index
    @event = Event.find(params[:event_id])
    @stats =  @event.load_locality_summary
    @assigned_lodgings_as_hospitality = @event.assigned_lodgings_as_hospitality
    @unassigned_lodgings_as_hospitality = @event.unassigned_lodgings_as_hospitality
  end

  def assign_lodging_to_locality
    # TODO: Add logic to update assignments
    @event = Event.find(params[:event_id])
    @hospitality = Hospitality.find(params[:event][:hospitality_id])
    @locality = Locality.find(params[:event][:locality_id])

    @hospitality.update_attributes(locality_id: @locality.id) unless !@hospitality.locality_id

    if @hospitality.save
      p 'success!'
      respond_with(@hospitality) do |f|
        f.html { redirect_to event_hospitality_assignments_path }
      end
    else
      p 'could not assign lodging to locality'
    end
  end

  def unassign_lodging_from_locality
    # TODO: Add logic to update assignments
    @event = Event.find(params[:event_id])
    @hospitality = Hospitality.find(params[:event][:hospitality_id])

    @hospitality.update_attributes(locality_id: nil) unless !@hospitality.locality_id

    if @hospitality.save
      p 'success!'
      respond_with(@hospitality) do |f|
        f.html { redirect_to event_hospitality_assignments_path }
      end
    else
      p 'could not unassign lodging from locality'
    end
  end
  def assign_registration_user_to_hospitality
    # TODO: Add logic to update assignments
    @event = Event.find(params[:event_id])
    @registration = Registration.find(params[:event][:registration_id])
    @locality = Locality.find(params[:event][:locality_id])

    # TODO: update this line for this method; copied from above jquery
    #@hospitality.update_attributes(locality_id: @locality.id) unless !@hospitality.locality_id

    if @hospitality.save
      p 'success!'
      respond_with(@hospitality) do |f|
        f.html { redirect_to event_hospitality_assignments_path }
      end
    else
      p 'could not assign'
    end
  end
  private

end
