# Policies for registration restful actions
class RegistrationPolicy < ApplicationPolicy
  def index?
    user.present? && (user.role?(:admin))
  end
end
