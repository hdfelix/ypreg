class Events::AttendancesController < ApplicationController
	def index
    @event = Event.includes(:registrations).find(params[:event_id])
		@registrations = @event.registrations 
    @event_localities = EventLocality.includes(:locality).where(event: @event)
	end
end
