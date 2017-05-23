class Events::LocalitiesController < ApplicationController
  decorates_assigned :all_locality_users, :event, :event_locality, :registrations, :users_not_registered

  def add
    authorize EventLocality
    @event = Event.find(params[:event_id])
  end

  def show
    @event_locality = EventLocality.find_by!(event_id: params[:event_id], locality_id: params[:id])
    authorize @event_locality

    @registrations = @event_locality.registrations.includes(:user)
    users_not_registered = @event_locality.locality.users.where.not(id: @event_locality.users.select(:id))
    @users_not_registered = policy_scope(users_not_registered)
    @tips_message = Payment.tips[:check_payment_instructions].html_safe
  end

  def new
    make_new(params[:event_id], params[:format])
  end

  def create
    make_new(params[:event_id], params[:locality_id])

    unless params.has_key?(:locality_user_ids)
      flash.now[:error] = "No users were selected!"
      render :new and return
    end

    users = @all_locality_users.find(params[:locality_user_ids]).map { |user| {user: user} }
    begin
      @event_locality.transaction(requires_new: true) do
        @event_locality.save!
        @event_locality.registrations.create!(users).map { |r| policy(r).create? } 
      end
    rescue ActiveRecord::RecordNotUnique
      retry
    rescue Exception => msg
      flash.now[:error] = "There was a problem creating these registrations: #{msg}"
      render :new and return
    end

    flash[:notice] = "Registrations added successfully."
    redirect_to event_path(params[:event_id])
  end

  private

  def make_new(event_id, locality_id)
    #TODO: move all locality users to decorator and kill this
    @event_locality = EventLocality.new(event_id: event_id, locality_id: locality_id)
    authorize @event_locality
    all_locality_users = @event_locality.locality.users
    @all_locality_users = policy_scope(all_locality_users).by_name
  end
end
