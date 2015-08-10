class Events::RegistrationsController < ApplicationController
  def index
    @event = Event.find(params[:event_id])
    @registrations =
      @event.registrations.
      sort_by { |reg| reg.locality.city } #.
      # sort_by { |reg| reg.user.role }.
      # sort_by { |reg| reg.user.name }
  end

  def show
    @event = Event.find(params[:event_id])

    # @registration = @event.registrations.where('user_id = ?', current_user)
    @registration = @event.registrations.where(id: params[:id])[0]
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
    @id = params[:id]
    @registration = @event.registrations.find(params[:id])
  end
  
  def update
    @event = Event.find(params[:event_id])
    @registration = registration.find(params[:id])

    if @registration.update_attributes(registration_params)
      flash[:notice] = 'Registration created succesfully'
      redirect_to event_registrations_path(@event)
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
  params.require(:registration).permit(:payment_type, :payment_adjustment, :has_been_paid, :has_medical_release_form, :attend_as_serving_one)
    .merge({ event_id: params[:event_id] })
    .merge({ locality_id: User.find(params[:user_id]).locality.id})
end
