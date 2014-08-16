class LodgingsController < ApplicationController
	before_action :set_lodging, only: [:show, :edit, :update, :destroy]

	def index
		@lodgings= Lodging.all
		authorize @lodgings
	end

  def show
    #@lodging set with 'before_action'
  end

  def new
		@lodging= Lodging.new
		authorize @lodging
  end

	def create 
		@lodging= Lodging.new(lodging_params)
		authorize @lodging

		if @lodging.save
			flash[:notice] = 'Lodging was created successfully.'
			redirect_to lodgings_path
    else
			flash[:error] = 'Error saving the lodging.'
			render action: 'new'
		end
	end

	def edit
    #@lodging set with 'before_action'
	end

	def update

		if @lodging.update(lodging_params)
			flash[:notice] = 'lodging was updated successfully.'
			redirect_to @lodging
		else
			flash[:error] = 'Error saving Lodging.'
			render action: 'edit'
		end

	end

  def destroy
    #@lodging set wtih 'before_action'
		if @lodging.destroy
			flash[:notice] = "Lodging #{ @lodging.name }deleted successfully."
			redirect_to lodgings_url
		else
			flash[:error] = "lodging could not be deleted."
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
		params.require(:lodging).permit(:name, :lodging_type, :contact_person_id, :locality_id, :max_capacity, :address1, :address2, :city, :state_abbrv, :zipcode)

	end
end
