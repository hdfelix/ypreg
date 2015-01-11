class Events::RegistrationsController < ApplicationController
  def index
    @event = Event.find(params[:event_id])
  end

  def show
    @event = Event.find(params[:event_id])
    @registration = @event.registrations.where('user_id = ?', current_user)
  end

  def new
    @event = Event.find(params[:event_id])
    @registration = Registration.new
  end

  def create
    @registration = current_user.registrations.build(registration_params)
    if @registration.save
      flash[:notice] = 'Registration created succesfully'
      redirect_to root_path
    else
      flash[:error] = 'Error creating registration'
      render 'new'
    end
  end

  def edit
    @event = Event.find(params[:event_id])
    @id = params[:id]
    # @registration = @event.registrations.find(params[:id])
    binding.pry
    t = 2
  end
  
  def update
    binding.pry
  end

  def destroy
    if @registration.destroy
      flash[:notice] = 'Registration deleted successfully.'
      redirect_to events_url
    else
      flash[:error] = 'Registration could not be deleted.'
      render action: 'index'
    end
  end
end

private

def registration_params
  params.require(:registration).permit(:event_id, :attend_as_serving_one)
end
