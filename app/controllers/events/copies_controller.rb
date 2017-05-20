class Events::CopiesController < ApplicationController
  def create
    event = Event.find(params[:event_id])
    @event = event.copy
    if @event.errors.count.zero?
      flash[:notice] = 'Event copied successfully.'
      redirect_to event_path(@event)
    else
      error_message = create_errors_message
      msg = "Event #{event.name} could not be copied: \n\ #{error_message}"
      flash[:error] = msg
    end
  end

  def create_errors_message
    errors = ''
    @event.errors.each do
      errors + " #{msg}\n"
    end
  end
end
