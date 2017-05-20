class Events::RegistrationsController < ApplicationController
  decorates_assigned :event, :event_lodgings, :registration, :registrations

  def index
    authorize Registration

    @event = Event.find(params[:event_id])
    registrations = @event.registrations.includes(:user, :locality)
    @registrations = policy_scope(registrations).by_user_name

    render 'attendance_index' if params[:view] == 'attendance'
  end

  def show
    registration = Registration.find(params[:id])
    authorize registration

    if params[:view] == 'attendance'
      @attendance = registration
      render 'attendance_show'
    else
      @registration = registration
    end
  end

  def new
    new_create(params[:event_id], params[:event_locality_id], params[:format])
  end

  def create
    new_create(params[:event_id], params[:event_locality_id], params[:user_id])

    if @registration.update(permitted_attributes(Registration))
      flash[:notice] = 'Registration created successfully'
      redirect_to event_registrations_path(@event)
    else
      flash[:error] = 'Error creating registration'
      render 'new'
    end
  end

  def edit
    @event = Event.find(params[:event_id])
    registration = @event.registrations.find(params[:id])
    authorize registration

    if params[:view] == 'attendance'
      @attendance = registration
      @user = @attendance.user
      render 'attendance_edit'
    else
      @registration = registration
    end

    event_lodging_ids = @event.event_lodgings.with_vacancy.pluck(:id)
    @event_lodgings = @event.event_lodgings.includes(:lodging).find(event_lodging_ids)
  end

  def update
    @event = Event.find(params[:event_id])
    @registration = @event.registrations.find(params[:id])
    authorize @registration

    if @registration.update(permitted_attributes(@registration))
      if params[:view] == 'attendance'
        flash[:notice] = 'Attendance updated successfully.'
      else
        flash[:notice] = 'Registration updated successfully.'
      end
      redirect_to event_registration_path(@event, @registration)
    else
      flash.now[:error] = 'error creating registration'
      render 'edit'
    end
  end

  def destroy
    @registration = Registration.find(params[:id])
    authorize @registration

    if @registration.destroy
      flash[:notice] = 'Registration deleted successfully.'
    else
      flash[:error] = 'registration could not be deleted.'
    end
    redirect_to event_registrations_path(@registration.event)
  end

  private

  def new_create(event_id, event_locality_id, user_id)
    @event = Event.find(event_id)
    if event_locality_id.present?
      event_locality = EventLocality.find(event_locality_id)
    else
      flash[:error] = 'Sorry, your locality is not registered for this event.'
      redirect_to '/' and return
    end
    if user_id.present?
      user = event_locality.locality.users.find(user_id)
    else
      user = current_user
    end

    @registration = Registration.new(event_locality: event_locality, user: user)
    authorize @registration
  end
end
