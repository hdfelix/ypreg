class HospitalitiesController < ApplicationController
  def index
		@hospitalities = Hospitality.all
  end

  def show
  end

  def new
		@event = Event.find(params[:event_id])
		@hospitality = Hospitality.new
  end

	private
	def hospitality_params
		params.require(:hospitality).permit()
	end
end
