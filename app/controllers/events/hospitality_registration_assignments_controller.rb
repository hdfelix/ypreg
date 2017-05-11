class Events::EventLodgingRegistrationAssignmentsController < ApplicationController
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
    saint_ids = params[:saint_event_lodging_ids].keys

    saint_ids.each do |id|
      hosp = nil
      event_lodging_id = params[:saint_event_lodging_ids][id.to_sym][0]
      hosp = EventLodging.find(event_lodging_id) if !event_lodging_id.empty?
      reg = Registration.where(event: @event, user: User.find(id)).first
      hra = @event.event_lodging_registration_assignments.find_by_registration_id(reg.id)

      if hosp.nil?
        remove_event_lodging_assignment(hra, reg)
      else
        create_or_update_event_lodging_assignment(hra, hosp, reg)
      end
    end

    if @event.save
      flash[:notice] = 'Assignments saved successfully.'
    else
      flash[:error] = 'Error saving assignments.'
    end

    redirect_to event_event_lodging_registration_assignments_path(@event)
  end

  private

  def remove_event_lodging_assignment(event_lodging_registration_assignment, registration)
    event_lodging_registration_assignment && event_lodging_registration_assignment.delete
    registration.update_attributes(event_lodging: nil)
  end

  def create_or_update_event_lodging_assignment(hra, hosp, reg)
    if hra.nil?
      create_event_lodging_assignment(hosp, reg)
    else
      update_event_lodging_registration_assignment(hra, hosp)
    end
    hosp.update_attributes(registration_id: reg.id)
    reg.update_attributes(event_lodging: hosp)
  end

  def create_event_lodging_assignment(event_lodging, registration)
    event_lodging_registration_assignment =
      @event
        .event_lodging_registration_assignments
        .build(
          event: @event,
          event_lodging: event_lodging,
          registration: registration,
          locality: @locality
        )
    event_lodging_registration_assignment.save
  end

  def update_event_lodging_registration_assignment(event_lodging_registration_assignment, event_lodging)
    event_lodging_registration_assignment
      .update_attributes(event_lodging: event_lodging, locality: @locality)
  end
end
