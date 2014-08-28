# Policies for event restful actions
class EventPolicy < ApplicationPolicy
  def index?
    user.present? && (user.role?(:admin))
  end
end
