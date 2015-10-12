# Policies for event copies restful actions
class EventCopyPolicy < ApplicationPolicy
  def new?
    user.present? && (user.role?(:admin))
  end

  def create?
    new?
  end
end
