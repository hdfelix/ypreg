class WelcomeController < ApplicationController
  decorates_assigned :events

  def index
    @events = Event.in_the_future
  end
end
