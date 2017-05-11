module Admin::UsersHelper
  def user_update
    params[:user].delete(:password) if params[:user][:password].blank?
    params[:user].delete(:password_confirmation) if params[:user][:password].blank? and params[:user][:password_confirmation].blank?

    @user = User.find(params[:id])
    authorize @user

    if @user.update(permitted_attributes(@user))
      flash[:notice] = "#{@user.name}'s profile was updated successfully."
      redirect_to session.delete(:return_to)
    else
      flash[:error] = "There was an error updating the profile for #{@user.name}."
      render "users/registrations/edit"
    end
  end
  
end
