class Users::RegistrationsController < Devise::RegistrationsController
  def index
    @users = User.all
  end
end
