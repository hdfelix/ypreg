class HospitalitiesController < ApplicationController
	before_action :set_hospitality, only: [:show, :edit, :update, :destroy]

	def index
		@hospitalities = Hospitality.all
	end

  def show
  end

  def new
		#@event = Hospitality.find(params[:event_id])
		@hospitality = Hospitality.new
  end

	def create 
		@hospitality = Hospitality.new(hospitality_params)
		if @hospitality.save
			flash[:notice] = 'Hospitality was created successfully.'
			redirect_to hospitalities_path
    else
			flash[:error] = 'Error saving the hospitality.'
			render action: 'new'
		end
	end

	def edit
	end

	def update

		if @hospitality.update(hospitality_params)
			flash[:notice] = 'Hospitality was updated successfully.'
			redirect_to @hospitality
		else
			flash[:error] = 'Error saving Hospitality.'
			render action: 'edit'
		end

	end

  def destroy
		if @hospitality.destroy
			flash[:notice] = "Hospitality #{ @hospitality.name }deleted successfully."
			redirect_to events_url
		else
			flash[:error] = "Hospitality could not be deleted."
			render action: 'index'
		end
  end

	private
	# Use callbacks to share common setup or constraints between actions.
	def set_hospitality
		@hospitality = Hospitality.find(params[:id])
	end
	
	def hospitality_params
		binding.pry
		params.require(:hospitality).permit(:name, :hospitality_type, :contact_person_id, :locality_id, :max_capacity, :address1, :address2, :city, :state_abbrv, :zipcode)

	end
end
