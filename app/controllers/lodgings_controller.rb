class LodgingsController < ApplicationController
  decorates_assigned :lodging, :lodgings

  def index
    authorize Lodging
    @lodgings = policy_scope(Lodging.all)
  end

  def show
    @lodging = Lodging.find(params[:id])
    authorize @lodging
  end

  def new
    @lodging = Lodging.new
    @lodging.location_id = params[:location_id] if params.has_key?(:location_id)
    authorize @lodging
  end

  def create
    @lodging = Lodging.new(permitted_attributes(Lodging))
    authorize @lodging

    if @lodging.save
      flash[:notice] = 'Lodging was created successfully.'
      redirect_to lodging_path(@lodging)
    else
      flash.now[:error] = 'Error saving the lodging.'
      render action: 'new'
    end
  end

  def edit
    @lodging = Lodging.find(params[:id])
    authorize @lodging
  end

  def update
    @lodging = Lodging.find(params[:id])
    authorize @lodging

    if @lodging.update(permitted_attributes(@lodging))
      flash[:notice] = 'lodging was updated successfully.'
      redirect_to lodging_path(@lodging)
    else
      flash.now[:error] = 'Error saving Lodging.'
      render action: 'edit'
    end
  end

  def destroy
    @lodging = Lodging.find(params[:id])
    authorize @lodging
    if @lodging.destroy
      flash[:notice] = "Lodging #{@lodging.name} deleted successfully."
      redirect_back fallback_location: lodgings_path
    else
      flash.now[:error] = 'lodging could not be deleted.'
    end
  end

end
