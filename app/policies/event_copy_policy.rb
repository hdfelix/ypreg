# Policies for event copies restful actions
class EventCopyPolicy < ApplicationPolicy
  def new?
    user.admin?
  end

  def create?
    new?
  end
end
