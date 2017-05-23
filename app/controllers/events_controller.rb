class EventsController < ApplicationController
  decorates_assigned :event, :events, :event_localities, :past_events

  def index
    authorize Event
    @events = policy_scope(Event).by_begin_date
  end

  def show
    @event = Event.find(params[:id])
    authorize @event

    event_localities = @event.event_localities.includes(:locality).by_city
    @event_localities = policy_scope(event_localities)
    #@stats = event.load_locality_summary
  end

  def new
    @event = Event.new
    authorize @event
  end

  def edit
    @event = Event.find(params[:id])
    authorize @event
  end

  def create
    @event = Event.new(permitted_attributes(Event))
    authorize @event

    if @event.save
      flash[:notice] = 'Event was successfully created.'
      redirect_to @event
    else
      flash.now[:error] = 'Error creating the event.'
      render action: 'new'
    end
  end

  def update
    @event = Event.find(params[:id])
    authorize @event

    if @event.update(permitted_attributes(@event))
      flash[:notice] = 'Event was successfully updated.'
      redirect_to @event
    else
      flash.now[:error] = 'Event could not be updated.'
      render action: 'edit'
    end
  end

  def destroy
    @event = Event.find(params[:id])
    authorize @event

    if @event.destroy
      flash[:notice] = "Event #{@event.name} deleted successfully."
      redirect_to events_url
    else
      flash.now[:error] = 'Event could not be deleted.'
    end
  end

  def edit_locality_payments
    @event = Event.find(params[:event_id])
    authorize @event

    event_localities = @event.event_localities.includes(:locality)
    @event_localities = policy_scope(event_localities).by_city
  end

  def update_locality_payments
    authorize Event

    event_localities = EventLocality.where(id: params[:locality_paid_ids])
    event_localities.transaction do
      event_localities.update_all(paid: true)
      event_localities.each do |event_locality|
        event_locality.registrations.update_all(paid: true)
      end
    end
    redirect_to edit_locality_payments_path
  end

end
