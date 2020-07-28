class Events::HospitalityAssignmentsController < ApplicationController
  skip_after_action:verify_authenticity_token
  # respond_to :html, :js

  def index
    @event = Event.find(params[:event_id]).includes(:hospitalities)
    @stats = @event.load_locality_summary
    @hospitalities = @event.hospitalities
    @assigned_lodgings_as_hospitality = @event.assigned_lodgings_as_hospitality
    @unassigned_lodgings_as_hospitality = @event.unassigned_lodgings_as_hospitality
    @participating_localities = @event.participating_localities

    # respond_to  do |format|
    #   format.html
    #     format.js {
    #       render partial: 'events/hospitality_assignments/units'
    #     }
    # end
  end

  def assign_lodging_to_locality
    # TODO: Add logic to update assignments
    @event = Event.find(params[:event_id])
    @hospitality = Hospitality.find(params[:event][:hospitality_id])
    @locality = Locality.find(params[:event][:locality_id])

    @hospitality.update_attributes(locality_id: @locality.id) unless !@hospitality.locality_id

    if @hospitality.save
      flash[:notice] = 'success!'
      respond_with(@hospitality) do |f|
        f.html { redirect_to event_hospitality_assignments_path }
        # f.js { render partial: 'units' }
      end
    else
      flash[:alert] = 'could not assign lodging to locality'
    end
  end

  def unassign_lodging_from_locality
    # TODO: Add logic to update assignments
    @event = Event.find(params[:event_id])
    @hospitality = Hospitality.find(params[:event][:hospitality_id])

    @hospitality.update_attributes(locality_id: nil) unless !@hospitality.locality_id

    if @hospitality.save
      flash[:notice] = 'success!'
      respond_with(@hospitality) do |f|
        f.html { redirect_to event_hospitality_assignments_path }
      end
    else
      flash[:alert] = 'could not unassign lodging from locality'
    end
  end

  def assign_registration_user_to_hospitality
    # TODO: Add logic to update assignments
    @event = Event.find(params[:event_id])
    @registration = Registration.find(params[:event][:registration_id])
    @locality = Locality.find(params[:event][:locality_id])
    hospitality_assignment =
      @event.hospitality_assignments.find_by_registration_id(@registration.id)

    # registration_id =  @registration.id,
    # hospitality_id = @event.hospitalities.where(
    # locality_id: @locality.id).first.id)

    event_registration_ids = @event.hospitality_assignments.pluck(:registration_id)

    if event_registration_ids.include?(@registration.id)
      flash[:alert] = 'is already assigned; updating hospitality_assignment'
      # if the current registration has already been assigned hospitalty
      # update hospitality_assignment with new hospitality via locality_id
      hospitality_assignment.update_attributes(
        registration_id: @registration.id,
        hospitality_id: @event.hospitalities.where(
          locality_id: @locality.id).first.id)
    else
      # add the new hospitality_assignment to @event.hospitality_assignments
      hospitality_assignment = @event.hospitality_assignments.new(
        registration_id: @registration.id,
        hospitality_id: @event.hospitalities.where(
          locality_id: @locality.id).first.id)

      if hospitality_assignment.save
        flash[:notice] = 'success!'
      else
        flash[:alert] = 'could not assign'
      end
    end
    respond_with(hospitality_assignment) do |f|
      f.html { redirect_to event_hospitality_assignments_path }
    end
  end
end
