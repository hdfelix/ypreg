class LodgingsController < ApplicationController
  before_action :set_lodging, only: [:edit, :update, :destroy]

  def index
    lodgings = policy_scope(Lodging)
    @lodgings = lodgings.decorate
  end

  def show
    lodging = Lodging.find(params[:id])
    authorize lodging
    @lodging = lodging.decorate
  end

  def new
    @lodging = Lodging.new
    @lodging.location_id = params[:location_id] if params.has_key?(:location_id)
    authorize @lodging
    session[:return_to] ||= request.referer
  end

  def create
    lodging = Lodging.new(lodging_params)
    authorize lodging

    if lodging.save
      flash[:notice] = 'Lodging was created successfully.'
      redirect_to session.delete(:return_to)
    else
      flash[:error] = 'Error saving the lodging.'
      render action: 'new'
    end
  end

  def edit
    # @lodging set with 'before_action'
  end

  def update
    if @lodging.update_attributes(lodging_params)
      flash[:notice] = 'lodging was updated successfully.'
      redirect_to @lodging
    else
      flash[:error] = 'Error saving Lodging.'
      render action: 'edit'
    end
  end

  def destroy
    if @lodging.destroy
      flash[:notice] = "Lodging #{@lodging.name} deleted successfully."
      redirect_to lodgings_url
    else
      flash[:error] = 'lodging could not be deleted.'
      render action: 'index'
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_lodging
    @lodging = Lodging.find(params[:id])
    authorize @lodging
  end

  def lodging_params
    params.require(:lodging).permit(
      :description,
      :location_id,
      :lodging_type,
      :max_capacity,
      :min_capacity,
      :name,
    )
  end
end
