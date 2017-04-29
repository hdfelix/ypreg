class Events::LocalitiesController < ApplicationController

  def index
    @event = Event.find(params[:event_id])
    event_localities = policy_scope(@event.localities).order(:city)
    @event_localities = event_localities.decorate
    other_localities = policy_scope(Locality.not_in(@event.localities)).order(:city)
    @other_localities = other_localities.decorate
  end

  def show
    @event = Event.find(params[:event_id])
    @locality = @event.localities.find(params[:id]).decorate
    @event_locality = EventLocality.where(event: @event, locality: @locality).first
    @users_not_registered = policy_scope(@locality.users.not_registered_for(@event))
    @registrations = Registration.locality_roster(@locality, @event)
    @tips_message = Payment.tips[:check_payment_instructions].html_safe
  end

  def new
    @event = Event.find(params[:event_id])
    @locality = Locality.find(params[:format])
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
          reg = Registration.find_or_create_by!(
            user: user,
            event: @event,
            locality: user.locality,
            has_medical_release_form: false,
            has_been_paid: false)
          @event.registrations << reg
        end
      end

      if @event.save
        flash[:notice] = "Registrations added successfully."
        redirect_to @event
      else
        flash[:error] = "There was a problem saving these event registrations."
        render action: 'new'
      end
    else
      flash[:error] = "No users were selected!"
      render action: 'new'
    end
  end
end
