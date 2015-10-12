class Events::CopiesController < ApplicationController
  def create
    event = Event.find(params[:event_id])
    @event = event.copy
    if @event.errors.count == 0
      flash[:notice] = 'Event copied successfully.'
      redirect_to event_path(@event)
    else
      errors ""
      @event.errors.each do |e|
        errors += " #{msg}\n"
      end

      msg = "Event #{event.title} could not be copied: \n\ #{errors}"
      flash[:error] = msg
    end
  end
end
