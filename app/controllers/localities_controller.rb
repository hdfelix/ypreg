class LocalitiesController < ApplicationController
  before_action :set_locality, only: [ :show, :edit, :update, :destroy]

	def index
		@localities = Locality.all
	end

	def show
	end

	def new
		@locality = Locality.new
	end

	def create
		@locality = Locality.new(locality_params)
		if @locality.save
			flash[:notice] = 'Locality was created successfully.'
			redirect_to localities_path
    else
			flash[:error] = 'Error saving the locality.'
			render action: 'new'
		end
	end

	def edit
	end

	def update
		if @locality.update(locality_params)
			flash[:notice] = 'Locality was updated successfully.'
			redirect_to @locality
		else
			flash[:error] = 'Error saving Locality.'
			render action: 'edit'
		end

	end

	private

	# Use callbacks to share common setup or constraints between actions.
	def set_locality
		@locality = Locality.find(params[:id])
	end
		
	def locality_params
		params.require(:locality).permit(:city, :state_abbrv, :contact_id)
	end
end
