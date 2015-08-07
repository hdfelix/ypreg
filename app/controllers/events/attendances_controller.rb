class Events::AttendancesController < ApplicationController
  def index
    @event = Event.find(params[:event_id])
    @registrations = @event.registrations.sort_by { |reg| reg.locality.city }
  end
end
