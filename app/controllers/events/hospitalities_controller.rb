class Events::HospitalitiesController < ApplicationController
  def index
    @event = Event.find(params[:event_id])
    @lodgings = @event.unassigned_lodgings_as_hospitality
    @hospitalities = @event.hospitalities
  end

  def add
    @event = Event.find(params[:event_id])
    ids_count = params[:lodging_ids].nil? ? 0 : params[:lodging_ids].count
    add_hospitalities_to_event(ids_count)

    if ids_count > 0 && @event.save
      flash[:notice] = 'Hospitalities added successfully.'
      redirect_to @event
    else
      flash[:error] = 'No lodgings selected.'
      redirect_to event_hospitalities_path(@event)
    end
  end

  def remove
    @event = Event.find(params[:event_id])
    hospitalities = 
      Hospitality
        .joins(:lodging)
        .where(lodging_id: params[:hospitality_lodging_ids])

    hospitalities.each(&:destroy)
    redirect_to @event
  end

  private

  def add_hospitalities(ids_count)
    ids_count.times do |c|
      lodging = Lodging.find(params[:lodging_ids][c])
      @event.hospitalities << Hospitality.create(lodging: lodging)
    end
  end
end
