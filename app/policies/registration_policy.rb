# Policies for registration restful actions
class RegistrationPolicy < ApplicationPolicy

  # TODO: testing... remove?
  def attendance_index?
    user.persent? && (user.role?(:admin))
  end

end
