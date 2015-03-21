# Policies for event restful actions
class EventPolicy < ApplicationPolicy
  def index?
    user.present? && (user.role?(:admin) || user.role?(:scyp))
  end
  def show?
    user.present? && (user.role?(:admin) || user.role?(:scyp))
  end
  def new?
    user.present? && (user.role?(:admin))
  end
end
