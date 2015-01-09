# Policies for user restful actions
class UserPolicy < ApplicationPolicy
  def index?
    user.present? && (user.role?(:admin))
  end
end
