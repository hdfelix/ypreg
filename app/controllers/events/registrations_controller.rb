class Events::RegistrationsController < ApplicationController
  def index
    @event = Event.find(params[:event_id])
    @registrations = @event.registrations.includes(:user).by_name
    if params[:view] == 'attendance'
      render 'attendance_index'
    end
  end

  def show
    @event = Event.find(params[:event_id])

    if params[:view] == 'attendance'
      @attendance = Registration.find(params[:id])
      render 'attendance_show'
    else
      @registration = Registration.find(params[:id])
    end
  end

  def new
    @event = Event.find(params[:event_id])
    if params[:format]
      @user = User.find(params[:format])
    else
      @user = current_user
    end
    @registration = Registration.new(user: @user, has_been_paid: false)
  end

  def create
    @event = Event.find(params[:event_id])
    user = User.find(params[:user_id])

    registration = Registration.new(registration_params)
    registration.user = user
    registration.event_locality = EventLocality.find_or_create_by(event: event, locality: user.locality)

    if registration.save
      flash[:notice] = 'Registration created successfully'
      redirect_to event_path(@event)
    else
      flash[:error] = 'Error creating registration'
      render 'new'
    end
  end

  def edit
    @event = Event.find(params[:event_id])
    if params[:view] == 'attendance'
      @attendance = Registration.find(params[:id])
      @user = @attendance.user
      render 'attendance_edit'
    else
      @id = params[:id]
      @registration = @event.registrations.find(params[:id])
    end
    session[:return_to] ||= request.referer
  end

  def update
    @event = Event.find(params[:event_id])
    @registration = Registration.find(params[:id])

    if @registration.update(registration_params)
      if params[:view] == 'attendance'
        flash[:notice] = 'Attendance updated successfully.'
      else
        flash[:notice] = 'Registration updated successfully.'
      end
      redirect_to session.delete(:return_to)
    else
      flash[:error] = 'error creating registration'
      render 'new'
    end
  end

  def destroy
    if @registration.destroy flash[:notice] =
        'registration deleted successfully.'
      redirect_to events_url
    else
      flash[:error] = 'registration could not be deleted.'
      render action: 'index'
    end
  end
end

private

def registration_params
  parameters = params.require(:registration).permit(
    :guest,
    :medical_release,
    :paid,
    :payment_adjustment,
    :payment_type,
    :serving_one,
    :vehicle_seating_capacity,
  )

  parameters = parameters.merge(params.require(:registration).permit(:status)) if params[:view] == 'attendance'
  parameters
end

def event_locality
  params.permit(:return_to)[:return_to]
end
