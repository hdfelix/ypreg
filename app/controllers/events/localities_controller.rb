class Events::LocalitiesController < ApplicationController

  def index
    @event = Event.find(params[:event_id])
    @event_localities = @event.localities
    @localities = Locality.localities_not_participating_in_event(@event)
  end

  def show
    @event = Event.find(params[:event_id])
    @locality = @event.localities.find(params[:id]).decorate
    @users_not_registered = decorated_users(@locality.users_not_registered(@event))
    @event_locality = EventLocality.where(event: @event, locality: @locality)[0]
    @registrations = @event_locality.registrations
    @tips_message = Payment.tips[:check_payment_instructions].html_safe
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

  private

  def decorated_users(users)
    users_to_decorate = User.where(id: users.map(&:id))
    # authorize users_to_decorate

    decorated_users = users_to_decorate.collect do |user|
      if user.role == 'yp'
        YpUserDecorator.decorate(user)
      else
        UserDecorator.decorate(user)
      end
    end
    decorated_users
  end
end
