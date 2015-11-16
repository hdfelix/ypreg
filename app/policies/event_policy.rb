# Policies for event restful actions
class EventPolicy < ApplicationPolicy
  def index?
    user.present? && (user.role?(:admin) || (user.role?(:scyp)))
  end

  def show?
    index?
  end

  def new?
    user.present? && user.role?(:admin)
  end

  def edit?
    new?
  end

  def update?
    new?
  end

  def create?
    new?
  end

  def destroy?
    new?
  end

  def copy?
    new?
  end
end
