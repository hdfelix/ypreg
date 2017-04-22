module Admin::UsersHelper
  def user_params
    common_params = [:email, :name, :gender, :age, :grade, :home_phone,
                     :work_phone, :cell_phone, :birthday]
    if current_user.admin?
      params.require(:user).permit(:role, :locality, :background_check_date,
                                   *common_params)
    elsif current_user.locality_contact?
      params.require(:user).permit(:role, *common_params)
    else
      params.require(:user).permit(*common_params)
    end
  end
end
