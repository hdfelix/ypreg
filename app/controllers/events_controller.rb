class EventsController < ApplicationController
  before_action :set_event, only: [ :show, :edit, :update, :destroy]

  def index
    @events = Event.all
  end

  def show
		@post = Event.find(params[:id])
  end

  def new
    @event = Event.new
		@event.build_location
		puts "******* #{@event.location.to_yaml}"
  end

  def edit
		@post = Event.find(params[:id])
  end

  def create
		@event = Event.new(event_params)
		#raise
		if @event.save
			redirect_to event_path, notice: 'Event was successfully created.'
		else
			#raise
			flash[:error] = "Error creating the event."
			render action: 'new'
		end
  end

  def update
    #respond_to do |format|
    #  if @event.update(event_params)
    #    format.html { redirect_to @event, notice: 'Event was successfully updated.' }
    #    format.json { head :no_content }
    #  else
    #    format.html { render action: 'edit' }
    #    format.json { render json: @event.errors, status: :unprocessable_entity }
    #  end
    #end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    #@event.destroy
    #respond_to do |format|
    #  format.html { redirect_to events_url }
    #  format.json { head :no_content }
    #end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
			params.require(:event).permit(:title, 
				locations_attributes: [:address1, :address2, :city, :state_abbrv, :zipcode])
    end
end
