module Admin::UsersHelper
  def admin_user_update
    params[:user].delete(:password) if params[:user][:password].blank?
    params[:user].delete(:password_confirmation) if params[:user][:password].blank? and params[:user][:password_confirmation].blank?

    @user = User.find(params[:id])
    authorize @user

    if @user.update(user_params)
      flash[:notice] = "#{@user.name}'s profile was updated successfully."
      redirect_to user_path(@user)
    else
      flash[:error] = "There was an error updating the profile for #{@user.name}."
      render "users/registrations/edit"
    end
  end
  
  def user_params
    policy = policy(User)
    common_params = [:email, :name, :gender, :age, :grade, :home_phone,
                     :work_phone, :cell_phone, :birthday, :password]

    if policy.scyp_edit?
      params.require(:user).permit(:role, :locality_id, :background_check_date,
                                   *common_params)
    elsif policy.role_edit?
      params.require(:user).permit(:role, *common_params)
    else
      params.require(:user).permit(*common_params)
    end
  end
end
