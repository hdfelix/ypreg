class LocalitiesController < ApplicationController
  decorates_assigned :locality, :localities, :users, :contacts

  def index
    if current_user.locality_contact?
      redirect_to current_user.locality
    end
    authorize Locality
    @localities = policy_scope(Locality).by_city
  end

  def show
    @locality = Locality.find(params[:id])
    authorize @locality
    @users = policy_scope(@locality.users)
    @contacts = @users.locality_contact
  end

  def new
    @locality = Locality.new
    authorize @locality
  end

  def create
    @locality = Locality.new(permitted_attributes(Locality))
    authorize @locality

    if @locality.save
      flash[:notice] = 'Locality was created successfully.'
      redirect_to locality_path(@locality)
    else
      flash.now[:error] = 'Error saving the locality.'
      render action: 'new'
    end
  end

  def edit
    @locality = Locality.find(params[:id])
    authorize @locality
  end

  def update
    @locality = Locality.find(params[:id])
    authorize @locality

    if @locality.update(permitted_attributes(@locality))
      flash[:notice] = 'Locality was updated successfully.'
      redirect_to @locality
    else
      flash.now[:error] = 'Error saving Locality.'
      render action: 'edit'
    end
  end

  def destroy
    @locality = Locality.find(params[:id])
    authorize @locality

    if @locality.destroy
      flash[:notice] = "Locality #{@locality.city} deleted successfully."
      redirect_to localities_url
    else
      flash.now[:error] = 'Locality could not be deleted.'
    end
  end

end
