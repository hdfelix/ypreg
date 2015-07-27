class Events::LocalitiesController < ApplicationController
  def index
    @event = Event.find(params[:event_id])
    @localities = Locality.localities_not_participating_in_event(@event)
    @event_localities = @event.localities
  end

  def show
    @event = Event.find(params[:event_id])
    # @locality = @event.localities.find(params[:id]) || Localities.find(params[:id])
    @locality = @event.localities.find(params[:id])
    @locality_users = @locality.users_not_registered(@event)
    @locality_registrations = @event.localities.find(@locality).registrations(@event)
  end

  def new
    @event = Event.find(params[:event_id])
    @locality = Locality.find(params[:locality_id])
    @event_locality = EventLocality.new
  end

  def create
    @event = Event.find(params[:event_id])
    @locality = Locality.find(params[:locality_id])
    @event_locality = EventLocality.new(event: @event, locality: @locality)
    @locality_user_ids = params[:locality_user_ids]

    unless @locality_user_ids.nil?
      ActiveRecord::Base.transaction do
        @locality_user_ids.each do |user_id|
          user = User.find(user_id)
          reg = Registration.new(
            user: user,
            event: @event,
            locality: user.locality,
            has_medical_release_form: false,
            has_been_paid: false)
          @event.registrations << reg
        end
      end
    end

    unless @localityuser_ids.nil?
      if @event.save
        flash[:notice] = "Registrations added successfully."
        redirect_to Event.find_by_title("Full-timer's Winter Gathering")
      else
        flash[:error] = "There was a problem saving these event registrations."
        render action: 'new'
      end
    else
      flash[:notice] = "No users were selected!"
      render action: 'new'
    end
  end
end
