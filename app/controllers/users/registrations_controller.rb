class Users::RegistrationsController < Devise::RegistrationsController
  include Admin::UsersHelper
  after_action :verify_authorized, except: [:index, :new, :create]
  after_action :verify_policy_scoped, only: :index

  def index
    users = policy_scope(User).order(:name)
    @users = users.decorate
  end

  def show
    user = User.find(params[:id])
    authorize user
    @user = user.decorate
  end

  def edit
    user = User.find(params[:format]).decorate
    authorize user
    @user = user.decorate
    if user == current_user
      @form_params = [resource, as: resource_name, url: registration_path(resource_name, id: user.id), method: :put]
    else
      @form_params = [[:admin, user], method: :patch]
    end
    session[:return_to] ||= request.referer
  end

  def update
    user_update
  end

end
