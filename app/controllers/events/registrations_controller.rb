class Events::RegistrationsController < ApplicationController

	#no index action since registrations are scoped to events

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
			flash[:notice] = "Registration created succesfully"
			redirect_to root_path
		else
			flash[:error] = "Error creating registration"
			render 'new'
		end

	end

	private

	def registration_params
		params.require(:registration).permit(:event_id)
	end
end
