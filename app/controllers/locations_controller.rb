class LocationsController < ApplicationController
  before_action :set_location, only: [:show, :edit, :update, :destroy]

  def index
		@locations = Location.all
		authorize @locations
  end

  def show
  end

  def new
    @location = Location.new
		authorize @location
  end

  def edit
  end

	def create
		@location = Location.new(location_params)
		authorize @location

		if @location.save
			flash[:notice] = 'Location was created successfully.'
			redirect_to locations_path
		else
			flash[:error] = 'Error saving the Location.'
			render action: 'new'
		end
	end

  def update
		if @location.update(location_params)
			flash[:notice] = 'Location was updated successfully.'
			redirect_to @location
		else
			flash[:error] = 'Error saving Location.'
			render action: 'edit'
		end
  end

  def destroy
		if @location.destroy
			redirect_to locations_url
		end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = Location.find(params[:id])
			authorize @location
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def location_params
      params.require(:location).permit(:name, :description, :max_capacity, :address1, :address2, :city, :state_abbrv, :zipcode) 
    end
end
