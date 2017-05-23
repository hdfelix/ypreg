class Events::LodgingsController < ApplicationController
  decorates_assigned :event, :event_lodging

  def show
    @event_lodging = EventLodging.find_by!(event_id: params[:event_id], lodging_id: params[:id])
    authorize @event_lodging
  end

  def add
    authorize EventLodging
    @event = Event.find(params[:event_id])
  end

  def create
    @event = Event.find(params[:event_id])

    unless params.has_key?(:lodging_ids)
      flash.now[:error] = 'No lodgings selected'
      render :add and return
    end

    lodgings = @event.location_lodgings.find(params[:lodging_ids]).map { |lodging| {lodging: lodging} }
    begin
      @event.transaction(requires_new: true) do
        @event.event_lodgings.create!(lodgings).map { |lo| policy(lo).create? }
      end
    rescue ActiveRecord::RecordNotUnique
      retry
    rescue Exception => msg
      flash.now[:error] = "There was a problem creating these lodgings: #{msg}"
      render :add and return
    end

    redirect_to event_path(@event, anchor: 'lodgings')
  end

  def remove
    #TODO: authorize
    event = Event.find(params[:event_id])
    if params.has_key?(:event_lodging_ids)
      removed_lodgings = event.event_lodgings.find(params[:event_lodging_ids])
      event.event_lodgings.destroy(removed_lodgings)
    else
      flash[:error] = 'No lodgings selected.'
    end
    redirect_to event_lodgings_path(event)
  end

end
