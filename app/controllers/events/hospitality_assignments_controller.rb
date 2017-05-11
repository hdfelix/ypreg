class Events::EventLodgingAssignmentsController < ApplicationController
  skip_filter :verify_authenticity_token, :action
  # respond_to :html, :js

  def index
    @event = Event.find(params[:event_id]).includes(:event_lodgings)
    @stats = @event.load_locality_summary
    @event_lodgings = @event.event_lodgings
    @assigned_lodgings_as_event_lodging = @event.assigned_lodgings_as_event_lodging
    @unassigned_lodgings_as_event_lodging = @event.unassigned_lodgings_as_event_lodging
    @participating_localities = @event.participating_localities

    # respond_to  do |format|
    #   format.html
    #     format.js {
    #       render partial: 'events/event_lodging_assignments/units'
    #     }
    # end
  end

  def assign_lodging_to_locality
    # TODO: Add logic to update assignments
    @event = Event.find(params[:event_id])
    @event_lodging = EventLodging.find(params[:event][:event_lodging_id])
    @locality = Locality.find(params[:event][:locality_id])

    @event_lodging.update_attributes(locality_id: @locality.id) unless !@event_lodging.locality_id

    if @event_lodging.save
      flash[:notice] = 'success!'
      respond_with(@event_lodging) do |f|
        f.html { redirect_to event_event_lodging_assignments_path }
        # f.js { render partial: 'units' }
      end
    else
      flash[:alert] = 'could not assign lodging to locality'
    end
  end

  def unassign_lodging_from_locality
    # TODO: Add logic to update assignments
    @event = Event.find(params[:event_id])
    @event_lodging = EventLodging.find(params[:event][:event_lodging_id])

    @event_lodging.update_attributes(locality_id: nil) unless !@event_lodging.locality_id

    if @event_lodging.save
      flash[:notice] = 'success!'
      respond_with(@event_lodging) do |f|
        f.html { redirect_to event_event_lodging_assignments_path }
      end
    else
      flash[:alert] = 'could not unassign lodging from locality'
    end
  end

  def assign_registration_user_to_event_lodging
    # TODO: Add logic to update assignments
    @event = Event.find(params[:event_id])
    @registration = Registration.find(params[:event][:registration_id])
    @locality = Locality.find(params[:event][:locality_id])
    event_lodging_assignment =
      @event.event_lodging_assignments.find_by_registration_id(@registration.id)

    # registration_id =  @registration.id,
    # event_lodging_id = @event.event_lodgings.where(
    # locality_id: @locality.id).first.id)

    event_registration_ids = @event.event_lodging_assignments.pluck(:registration_id)

    if event_registration_ids.include?(@registration.id)
      flash[:alert] = 'is already assigned; updating event_lodging_assignment'
      # if the current registration has already been assigned hospitalty
      # update event_lodging_assignment with new event_lodging via locality_id
      event_lodging_assignment.update_attributes(
        registration_id: @registration.id,
        event_lodging_id: @event.event_lodgings.where(
          locality_id: @locality.id).first.id)
    else
      # add the new event_lodging_assignment to @event.event_lodging_assignments
      event_lodging_assignment = @event.event_lodging_assignments.new(
        registration_id: @registration.id,
        event_lodging_id: @event.event_lodgings.where(
          locality_id: @locality.id).first.id)

      if event_lodging_assignment.save
        flash[:notice] = 'success!'
      else
        flash[:alert] = 'could not assign'
      end
    end
    respond_with(event_lodging_assignment) do |f|
      f.html { redirect_to event_event_lodging_assignments_path }
    end
  end
end
