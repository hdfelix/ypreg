class Events::RegistrationsController < ApplicationController
  def index
    @event = Event.find(params[:event_id])
    @registrations =
      @event.registrations.sort_by { |reg| reg.locality.city } #.

      if params[:view] == 'attendance'
        @event_localities = EventLocality.includes(:locality).where(event: @event)
        render 'attendance_index'
      end
  end

  def show
    @event = Event.find(params[:event_id])

    # @registration = @event.registrations.where('user_id = ?', current_user)
    if params[:view] == 'attendance'
      @attendance = Registration.find(params[:id])
      render 'attendance_show'
    else
      @registration = @event.registrations.where(id: params[:id])[0]
    end
  end

  def new
    @event = Event.find(params[:event_id])
    if params[:format]
      @user = User.find(params[:format])
    else
      @user = current_user
    end
    @registration = Registration.new(user: @user)
  end

  def create
    @event = Event.find(params[:event_id])
    @user = User.find(params[:user_id])
    @registration = @user.registrations.new(registration_params)
    if @registration.save
      flash[:notice] = 'Registration created succesfully'
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
  end
  
  def update
    @event = Event.find(params[:event_id])
    @registration = Registration.find(params[:id])

    if @registration.update_attributes(registration_params)
      if params[:view] == 'attendance'
        flash[:notice] = 'Attendance created succesfully'
        redirect_to event_registrations_url(@event,view: 'attendance')
      else
        flash[:notice] = 'Registration created succesfully'
        redirect_to event_registrations_path(@event)
      end
    else
      flash[:error] = 'error creating registration'
      render 'new'
    end
  end

  def destroy
    if @registration.destroy flash[:notice] = 'registration deleted successfully.'
      redirect_to events_url
    else
      flash[:error] = 'registration could not be deleted.'
      render action: 'index'
    end
  end
end

private

def registration_params
  parameters = params.require(:registration).permit(:payment_type, :payment_adjustment, :has_been_paid, :has_medical_release_form, :attend_as_serving_one)
    .merge({ event_id: params[:event_id] })
    .merge({ locality_id: User.find(params[:user_id]).locality.id})

  parameters.merge(params.require(:registration).permit(:status)) if params[:view] == 'attendance'
end
