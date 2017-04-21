module Admin::UsersHelper
  def user_params
    params[:user].permit(:role, :email, :locality, :name, :gender, :age,
                         :grade, :home_phone, :work_phone, :cell_phone,
                         :background_check_date, :birthday)
  end
end
