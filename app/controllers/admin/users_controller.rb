class Admin::UsersController < ApplicationController
  include Admin::UsersHelper
  after_action :verify_authorized

  def new
    @user = User.new()
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
      flash[:error] = 'Error saving the user.'
      render action: 'new'
    end
  end

end
