class Admin::UsersController < ApplicationController
  include Admin::UsersHelper
  after_action :verify_authorized

  def new
    @user = User.new()
    if params[:locality_id].present?
      @user.locality_id = params[:locality_id]
    end
    authorize @user
  end

  def create
    @user = User.new(user_params)
    @user.skip_confirmation!
    authorize @user

    if @user.save
      flash[:notice] = 'User was created successfully.'
      redirect_to users_path
    else
      flash.now[:error] = 'Error saving the user.'
      render action: 'new'
    end
  end

  def update
    user_update
  end

  def destroy
    @user = User.find(params[:id])
    authorize @user
    if current_user != @user
      @user.destroy
      redirect_to users_path
    end
  end

end
