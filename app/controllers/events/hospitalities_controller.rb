class Events::HospitalitiesController < ApplicationController
  def assign
    @hospitalities = Hospitality.new
  end

  def assigns
    @hospitality = Hospitality.find(params[:event][:hospitality_id])
    @event = Event.find(params[:event_id])
    @event.hospitalities << @hospitality

    respond_to do |format|
      format.html { redirect_to @event }
      format.js
    end
  end

  def destroy
    @event = Event.find(params[:event_id])
    @hospitality = @event.hospitalities.find(params[:id])
    @event.hospitalities.delete(@hospitality)

    respond_to do |format|
      format.html {redirect_to @event }
      format.js
    end
  end
end
