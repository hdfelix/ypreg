class Users::RegistrationsController < Devise::RegistrationsController
  def index
    @users = User.includes(:locality).all
  end

  def show
    # using current_user from devise on this action...
  end
end
