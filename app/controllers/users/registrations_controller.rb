class Users::RegistrationsController < Devise::RegistrationsController
  include Admin::UsersHelper
  before_action :set_user, only: [:show, :update, :destroy]
  after_action :verify_authorized, only: [:show, :edit, :update, :destroy]
  after_action :verify_policy_scoped, only: :index

  def index
    @users = decorated_users
  end

  def edit
    @user = User.find(params[:format])
    authorize @user
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "#{@user.name}'s profile was updated successfully."
      redirect_to users_path
    else
      flash[:error] = "There was an error updating the profile for #{@user.name}."
      render action: 'edit'
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
    authorize @user
  end

  def decorated_users
    users = policy_scope(User)
    decorated_users = users.collect do |user|
      if user.role?(:yp)
        YpUserDecorator.decorate(user)
      else
        UserDecorator.decorate(user)
      end
    end
  end

end
