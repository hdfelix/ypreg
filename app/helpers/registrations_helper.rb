module RegistrationsHelper
  def controlVisibilityPerRole
    "true" if current_user.role == 'yp'
  end
end
