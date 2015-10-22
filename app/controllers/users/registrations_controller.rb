class Users::RegistrationsController < Devise::RegistrationsController
  def index
    @users = decorated_users
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:format])
  end

  def create
    super
  end

  def update
    @user = User.find(params[:id])

    if @user.update(admin_update_params)
      flash[:notice] = "#{@user.name}'s profile was updated successfully."
      redirect_to users_path
    else
      flash[:error] = "There was an error updating the profile for #{@user.name}."
      render action: 'edit'
    end
  end

  private

  def decorated_users
    users = User.includes(:locality).all
    authorize users

    decorated_users = users.collect do |user|
      if user.role == 'yp'
        YpUserDecorator.decorate(user)
      else
        UserDecorator.decorate(user)
      end
    end
    decorated_users
  end

  def admin_update_params
    params[:user]
      .permit(:role, :email, :locality, :name, :gender, :age, :grade, :home_phone,
              :work_phone, :cell_phone, :background_check_date, :birthday)
  end
end
