class Events::LocalitiesController < ApplicationController

  def index
    @event = Event.includes(:event_localities).find(params[:event_id])
    @event_localities = policy_scope(@event.event_localities).by_city
    @other_localities = policy_scope(Locality.where.not(id: @event_localities.pluck(:locality_id))).by_city
  end

  def show
    event_locality = EventLocality.find_by!(event_id: params[:event_id], locality_id: params[:id])
    @event = event_locality.event
    @locality = event_locality.locality
    @registrations = event_locality.registrations.includes(:user)
    @role_counts = event_locality.users.role_counts
    @lodgings = event_locality.event_lodgings
    users_not_registered = event_locality.users_not_registered
    @users_not_registered = policy_scope(users_not_registered).decorate
    @tips_message = Payment.tips[:check_payment_instructions].html_safe
  end

  def new
    @event = Event.find(params[:event_id])
    @locality = Locality.find(params[:format])
    users = policy_scope(@locality.users).order(:name)
    @users = users.decorate
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
          )
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
