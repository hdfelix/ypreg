class WelcomeController < ApplicationController
  def index
    @events = Event.in_the_future
  end
end
