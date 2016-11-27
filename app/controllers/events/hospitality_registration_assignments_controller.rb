class Events::HospitalityRegistrationAssignmentsController < ApplicationController
  def index
    @event = Event.find(params[:event_id])
    @event_localities = EventLocality.where(event: @event).sort { |a, b| a.locality_city <=> b.locality_city }
  end

  def show
    @event = Event.find(params[:event_id])
    @locality = Locality.find(params[:locality_id])
  end

  def assign
    @event = Event.find(params[:event_id])
    @locality = Locality.find(params[:locality_id])
    saint_ids = params[:saint_hospitality_ids].keys

    saint_ids.each do |id|
      hosp = nil
      hospitality_id = params[:saint_hospitality_ids][id.to_sym][0]
      hosp = Hospitality.find(hospitality_id) if !hospitality_id.empty?
      reg = Registration.where(event: @event, user: User.find(id)).first
      hra = @event.hospitality_registration_assignments.find_by_registration_id(reg.id)

      if hosp.nil?
        remove_hospitality_assignment(hra, reg)
      else
        create_or_update_hospitality_assignment(hra, hosp, reg)
      end
    end

    if @event.save
      flash[:notice] = 'Assignments saved successfully.'
    else
      flash[:error] = 'Error saving assignments.'
    end

    redirect_to event_hospitality_registration_assignments_path(@event)
  end

  private

  def remove_hospitality_assignment(hospitality_registration_assignment, registration)
    hospitality_registration_assignment && hospitality_registration_assignment.delete
    registration.update_attributes(hospitality: nil)
  end

  def create_or_update_hospitality_assignment(hra, hosp, reg)
    if hra.nil?
      create_hospitality_assignment(hosp, reg)
    else
      update_hospitality_registration_assignment(hra, hosp)
    end
    hosp.update_attributes(registration_id: reg.id)
    reg.update_attributes(hospitality: hosp)
  end

  def create_hospitality_assignment(hospitality, registration)
    hospitality_registration_assignment =
      @event
        .hospitality_registration_assignments
        .build(
          event: @event,
          hospitality: hospitality,
          registration: registration,
          locality: @locality
        )
    hospitality_registration_assignment.save
  end

  def update_hospitality_registration_assignment(hospitality_registration_assignment, hospitality)
    hospitality_registration_assignment
      .update_attributes(hospitality: hospitality, locality: @locality)
  end
end
