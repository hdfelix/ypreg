class Users::RegistrationsController < Devise::RegistrationsController
  include Admin::UsersHelper
  after_action :verify_authorized, except: [:index, :new, :create]
  after_action :verify_policy_scoped, only: :index

  def index
    @users = policy_scope(User).decorate
  end

  def show
    @user = User.find(params[:id]).decorate
    authorize @user
  end

  def edit
    @user = User.find(params[:format]).decorate
    authorize @user

    if @user == current_user
      @form_params = [resource, as: resource_name, url: registration_path(resource_name, id: @user.id), method: :put]
    else
      @form_params = [[:admin, @user], method: :patch]
    end
  end

  def update
    admin_user_update
  end

end
