class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    @events = Event.not_over
    authorize @events

    @past_events = Event.in_the_past
    authorize @past_events
  end

  def show
    # @event set & authorized with 'before_action'
    @stats = @event.load_locality_summary
  end

  def new
    @event = Event.new
    authorize @event
  end

  def edit
    # @event set & authorized  with 'before_action'
    @return_to = params[:r]
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

  def update
    @return_to = params[:r]
    # @event set & authorized with 'before_action'
    if @event.update(event_params)
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
    localities = Locality.find(params[:locality_paid_ids])

    ActiveRecord::Base.transaction do
      localities.each do |loc|
        registrations = Registration.where(event: @event, locality: loc)
        event_localities = EventLocality.where(event: @event, locality: loc)

        flip_has_been_paid_flag_for(registrations)
        flip_submitted_registration_payment_flag_for(event_localities)
      end
      redirect_to edit_locality_payments_path
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])
    authorize @event
    @participating_localities =
      @event.participating_localities.sort { |a, b| a.city <=> b.city }
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

  def flip_has_been_paid_flag_for(registrations)
    # Flip 'has_been_paid' value for registrations of selected locality
    registrations.each do |reg|
      if reg.has_been_paid == true
        reg.update_attributes(has_been_paid: false)
      else
        reg.update_attributes(has_been_paid: true)
      end
      reg.save
    end
  end

  def flip_submitted_registration_payment_flag_for(event_localities)
    # TODO: Flip 'submited_registraiton_payment_check for
    # event localities of selected locality
    event_localities.each do |el|
      if el.submitted_registration_payment_check == true
        el.update_attributes(submitted_registration_payment_check: false)
      else
        el.update_attributes(submitted_registration_payment_check: true)
      end
      el.save
    end
  end
end
