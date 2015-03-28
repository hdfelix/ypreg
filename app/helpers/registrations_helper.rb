module RegistrationsHelper
  def controlVisibilityPerRole
    "true" unless current_user.role == 'admin'
  end
end
