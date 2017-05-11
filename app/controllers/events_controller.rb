class EventsController < ApplicationController
  before_action :set_event, only: [:show, :destroy]

  def index
    @events = Event.not_over
    authorize @events
    @past_events = Event.in_the_past
    authorize @past_events
  end

  def show
    @event = Event.includes(:event_localities, :registrations, :location).find(params[:id])
    authorize @event
    #@stats = @event.load_locality_summary
    @role_counts = @event.users.role_counts
    @registrations = @event.registrations
    @event_localities = policy_scope(@event.event_localities).by_city
  end

  def new
    @event = Event.new
    authorize @event
  end

  def edit
    @event = Event.find(params[:id])
    authorize @event
    @participating_localities = @event.localities
    @return_to = params[:r]
  end

  def create
    @event = Event.new(permitted_attributes(@event))
    authorize @event

    if @event.save
      redirect_to events_path, notice: 'Event was successfully created.'
    else
      flash[:error] = 'Error creating the event.'
      render action: 'new'
    end
  end

  def update
    @event = Event.find(params[:id])
    authorize @event
    @participating_localities = @event.localities

    if @event.update(permitted_attributes(@event))
      redirect_to @event, notice: 'Event was successfully updated.'
    else
      flash[:error] = 'Event could not be updated.'
      render action: 'edit'
    end
  end

  def destroy
    # @event set & authorized with 'before_action'
    if @event.destroy
      flash[:notice] = "Event #{@event.title}deleted successfully."
      redirect_to events_url
    else
      flash[:error] = 'Event could not be deleted.'
      render action: 'index'
    end
  end

  def edit_locality_payments
    @event = Event.find(params[:event_id])
    @event_localities = EventLocality.where(event: @event)
  end

  def update_locality_payments
    @event = Event.find(params[:event_id])
    localities = Locality.where(id: params[:locality_paid_ids])

    ActiveRecord::Base.transaction do
      @event.event_localities.for_locality(localities).update_all(paid: true)
      @event.registrations.for_locality(localities).update_all(paid: true)
    end
    redirect_to edit_locality_payments_path
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])
    authorize @event
    @participating_localities = @event.event_localities
  end
end
