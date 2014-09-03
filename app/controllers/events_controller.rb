class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    @events = Event.all
    authorize @events
  end

  # GET /event/1
  def show
    # @event set with 'before_action'
    @stats =  @event.load_locality_summary
  end

  def new
    @event = Event.new
    authorize @event
  end

  def edit
    # @event set with 'before_action'
  end

  def create
    @event = Event.new(event_params)
    authorize @event

    if @event.save
      redirect_to events_path, notice: 'Event was successfully created.'
    else
      flash[:error] = 'Error creating the event.'
      render action: 'new'
    end
  end

  # POST /event/1
  def update
    # @event set with 'before_action'
    if @event.update(event_params)
      redirect_to @event, notice: 'Event was successfully updated.'
    else
      flash[:error] = 'Event could not be updated.'
      render action: 'edit'
    end
  end

  # DELETE /events/1
  def destroy
    # @event set with 'before_action'
    if @event.destroy
      flash[:notice] = "Event #{@event.title}deleted successfully."
      redirect_to events_url
    else
      flash[:error] = 'Event could not be deleted.'
      render action: 'index'
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])
    authorize @event
  end

  # Never trust parameters from the scary internet,
  # only allow the white list through.
  def event_params
    params.require(:event)
      .permit(
        :event_type,
        :title,
        :begin_date,
        :end_date,
        :registration_cost,
        :registration_open_date,
        :registration_close_date,
        :location_id)
  end
end
