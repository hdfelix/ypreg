class LocalitiesController < ApplicationController
  before_action :set_locality, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index

  def index
    @localities = policy_scope(Locality)
  end

  def new
    @locality = Locality.new
    authorize @locality
  end

  def create
    @locality = Locality.new(locality_params)
    authorize @locality

    if @locality.save
      flash[:notice] = 'Locality was created successfully.'
      redirect_to localities_path
    else
      flash[:error] = 'Error saving the locality.'
      render action: 'new'
    end
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

  def destroy
    locality_name = @locality.city
    if @locality.destroy
      flash[:notice] = "Locality #{locality_name} deleted successfully."
      redirect_to localities_url
    else
      flash[:error] = 'Locality could not be deleted.'
      render :index
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_locality
    @locality = Locality.find(params[:id])
    authorize @locality
  end

  def locality_params
    params.require(:locality).permit(:city, :state_abbrv, :contact_id)
  end
end
