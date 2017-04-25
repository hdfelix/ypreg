class Users::RegistrationsController < Devise::RegistrationsController
  include Admin::UsersHelper
  after_action :verify_authorized, except: [:index, :new, :create]
  after_action :verify_policy_scoped, only: :index

  def index
    @users = policy_scope(User).decorate
  end

  def show
    @user = User.find(params[:id])
    authorize @user
  end

  def edit
    @user = User.find(params[:format])
    authorize @user
    @user.decorate
  end

  def update
    @user = User.find(params[:id])
    authorize @user
    if @user.update(user_params)
      flash[:notice] = "#{@user.name}'s profile was updated successfully."
      redirect_to users_path
    else
      flash[:error] = "There was an error updating the profile for #{@user.name}."
      render action: 'edit'
    end
  end

end
