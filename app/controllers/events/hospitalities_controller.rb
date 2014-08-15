class Events::HospitalitiesController < ApplicationController
  def assign
    #@hospitalities = Hospitality.new
    # Lodgings that could be assigned as available for the given event
    @lodging = lodgings_for_assign
  end

  def assigns
    #calling lodging here hospitality; getting an error if I use @lodging on the assings.js render
    @hospitality = Lodging.find(params[:lodging_id])
    @event = Event.find(params[:event_id])
    @event.hospitalities << Hospitality.create(event_id: @event.id, lodging_id: @hospitality.id)

    respond_to do |format|
      format.html { redirect_to @event }
      format.js
    end
  end

  def destroy
    @event = Event.find(params[:event_id])
    binding.pry
    @hospitality = @event.hospitalities.find(params[:id])
    binding.pry
    @event.hospitalities.delete(@hospitality)

    respond_to do |format|
      format.html {redirect_to @event }
      format.js
    end
  end

  private
  def lodgings_for_assign
    ev = Event.find(params[:event_id])
    if ev.hospitalities.empty?
      Lodging.all
    else
      Lodging.where.not(id: ev.hospitalities.pluck(:lodging_id))
    end
  end
end
