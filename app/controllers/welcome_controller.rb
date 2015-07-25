class WelcomeController < ApplicationController
  def index
    @events = Event.in_the_future

    # Values for aria chart
    # @chart_values = widget_stats_next_event
  end
end
