class Events::HospitalityRegistrationAssignmentsController < ApplicationController
  def index
    @event = Event.find(params[:event_id])
  end

  def show
    @event = Event.find(params[:event_id])
    # :id is the locality for which we are doing an event registration assignment
    @locality = Locality.find(params[:id])
  end

  def assign
    @event = Event.find(params[:event_id])
    @locality = Locality.find(params[:locality_id])
    saint_ids = params[:saint_hospitality_ids].keys

    saint_ids.each do |id|
      hosp = nil
      hospitality_id = params[:saint_hospitality_ids][id.to_sym][0]

      if !hospitality_id.empty?
      # if !lodging_id.empty?
        hosp = Hospitality.find(hospitality_id)
      end
      reg = Registration.where(event: @event, user: User.find(id)).first

      if hosp.nil?
        # remove HospitalityRegistrationAssignment if it exists
        hra = @event.hospitality_registration_assignments.find_by_registration_id(reg.id)
        if !hra.nil?
          hra.delete
        end
      else
        # create or update HospitalityRegistrationAssignment
        hra = @event.hospitality_registration_assignments.find_by_registration_id(reg.id)
        if hra.nil?
          # Build a new HospitalityRegistrationAssignment record
          hra = 
            @event.hospitality_registration_assignments
            .build(hospitality: hosp, registration: reg)
          hra.save
        else
          # Update the existing HospitalityRegistrationAssignment
          hra.update_attributes(hospitality: hosp)
          hra.save
        end
      end
    end

    if @event.save
      flash[:notice] = "Assignments saved successfully."
    else
      flash[:error] = "Error saving assignments."
    end

    redirect_to event_hospitality_registration_assignment_path(@event, @locality)
  end
end
