class Users::RegistrationsController < Devise::RegistrationsController
  include Admin::UsersHelper
  decorates_assigned :user, :users

  def index
    authorize User
    @users = policy_scope(User).by_name
  end

  def show
    @user = User.find(params[:id])
    authorize @user
  end

  def edit
    @user = User.find(params[:format])
    authorize @user
    if @user == current_user
      @form_params = [resource, as: resource_name, url: registration_path(resource_name, id: @user.id), method: :put]
    else
      @form_params = [[:admin, @user], method: :patch]
    end
  end

  def update
    user_update
  end

end
