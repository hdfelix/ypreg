class LocationsController < ApplicationController
  decorates_assigned :location, :locations, :lodgings

  def index
    authorize Location
    @locations = policy_scope(Location).by_name
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

  def create
    @location = Location.new(permitted_attributes(Location))
    authorize @location

    if @location.save
      flash[:notice] = 'Location was created successfully.'
      redirect_to @location
    else
      flash.now[:error] = 'Error saving the Location.'
      render action: 'new'
    end
  end

  def edit
    @location = Location.find(params[:id])
    authorize @location
  end

  def update
    @location = Location.find(params[:id])
    authorize @location

    if @location.update(permitted_attributes(@location))
      flash[:notice] = 'Location was updated successfully.'
      redirect_to @location
    else
      flash.now[:error] = 'Error saving Location.'
      render action: 'edit'
    end
  end

  def destroy
    @location = Location.find(params[:id])
    authorize @location

    if @location.destroy
      flash[:notice] = "Location #{@location.name} deleted successfully."
      redirect_to locations_url
    else
      flash.now[:error] = 'Location could not be deleted.'
    end
  end

end
