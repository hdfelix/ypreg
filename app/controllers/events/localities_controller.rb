class Events::LocalitiesController < ApplicationController
  def show
    event = Event.find(params[:event_id])
    @locality = event.localities.find(params[:id])
    @locality_users = @locality.users
    @locality_registrations = event.localities.find(@locality).registrations(event)
  end
end
