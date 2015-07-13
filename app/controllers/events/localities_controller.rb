class Events::LocalitiesController < ApplicationController
  def show
    @event = Event.find(params[:event_id])
    @locality = @event.localities.find(params[:id])
    @locality_users = @locality.users_not_registered(@event)
    @locality_registrations = @event.localities.find(@locality).registrations(@event)
  end
end
