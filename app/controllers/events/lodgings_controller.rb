class Events::LodgingsController < ApplicationController
  decorates_assigned :event, :event_lodgings, :other_lodgings

  def index
    authorize EventLodging

    @event = Event.find(params[:event_id])
    event_lodgings = @event.event_lodgings.includes(:lodging)
    @event_lodgings = policy_scope(event_lodgings)
    other_lodgings = @event.location_lodgings.where.not(id: @event.event_lodgings.pluck(:lodging_id))
    @other_lodgings = policy_scope(other_lodgings)
  end

  def add
    event = Event.find(params[:event_id])
    if params.has_key?(:lodging_ids)
      lodging_ids = params[:lodging_ids].map { |id| {lodging_id: id} }
      event.event_lodgings.create(lodging_ids)
    else
      flash[:error] = 'No lodgings selected.'
    end
    redirect_to event_lodgings_path(event)
  end

  def remove
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
