# Policies for event restful actions
class EventPolicy < ApplicationPolicy
  def index?
    user.admin? or user.locality_contact?
  end

  def show?
    index? or user.role?(:speaking_brother)
  end

  def copy?
    user.admin?
  end
end
