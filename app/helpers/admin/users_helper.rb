module Admin::UsersHelper
  def user_params
    policy = policy(User)
    common_params = [:email, :name, :gender, :age, :grade, :home_phone,
                     :work_phone, :cell_phone, :birthday]
    if policy.scyp_edit?
      params.require(:user).permit(:role, :locality, :background_check_date,
                                   *common_params)
    elsif policy.role_edit?
      params.require(:user).permit(:role, *common_params)
    else
      params.require(:user).permit(*common_params)
    end
  end
end
