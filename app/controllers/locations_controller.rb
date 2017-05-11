class LocationsController < ApplicationController
  before_action :set_location, only: [:edit, :update, :destroy]

  def index
    @locations = policy_scope(Location).order(:name)
  end

  def show
    @location = Location.includes(:lodgings).find(params[:id])
    authorize @location
    @lodgings = policy_scope(@location.lodgings)
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
      flash[:notice] = "Location #{ @location.name } deleted successfully."
      redirect_to locations_url
    else
      flash[:error] = 'Location could not be deleted.'
      render :index
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_location
    @location = Location.find(params[:id])
    authorize @location
  end

  # Never trust parameters from the scary internet,
  # only allow the white list through.
  def location_params
    params.require(:location)
      .permit(
        :location_type,
        :name,
        :description,
        :max_capacity,
        :address1,
        :address2,
        :city,
        :state,
        :zipcode)
  end
end
