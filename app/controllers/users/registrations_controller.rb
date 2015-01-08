class Users::RegistrationsController < Devise::RegistrationsController
  def index
    @users = User.includes(:locality).all
  end
end
