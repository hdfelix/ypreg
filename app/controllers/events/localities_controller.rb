class Events::LocalitiesController < ApplicationController
  def show
    @locality = Event.find(params[:event_id]).localities.find(params[:id])
  end
end
