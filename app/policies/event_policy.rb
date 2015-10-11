# Policies for event restful actions
class EventPolicy < ApplicationPolicy
  def index?
    user.present? && (user.role?(:admin))
  end

  def new?
    index?
  end

  def create?
    index?
  end

  def copy?
    index?
  end
end
