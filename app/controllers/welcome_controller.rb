class WelcomeController < ApplicationController
  def index
    @events = Event.all

    # Values for aria chart
    # @chart_values = widget_stats_next_event
  end
end
