class Users::RegistrationsController < Devise::RegistrationsController
  # prepend_before_filter :require_no_authentication, only: [:new, :create, :cancel]
  def index
    @users = User.includes(:locality).all
    authorize @users
  end

  def show
    # using current_user from devise on this action...
  end

  def edit
    @user = User.find(params[:format])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(admin_update_params)
      flash[:notice] = "#{ @user.name }'s profile was updated successfully."
      redirect_to users_path
    else
      flash[:error] = "There was an error updating the profile for #{ @user.name }."
      render action: 'edit'
    end
  end

  def admin_new
    binding.pry
    @user= User.new
  end

  private

  def admin_update_params
    params[:user].permit(:role, :email, :name, :gender, :home_phone, :work_phone, :cell_phone, :birthday)
  end
end
