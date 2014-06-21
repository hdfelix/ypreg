class RegistrationsController < ApplicationController
  def index
  end

	def new
		@event = Event.find(params[:event_id])
		@registration = Registration.new
	end

	def create
		#binding.pry
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
