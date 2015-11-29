# Policies for event payments restful actions
class EventPaymentPolicy < ApplicationPolicy
  def index?
    user.present? &&
      (user.role?(:admin) ||
       user.role?(:scyp))
  end

  def show?
    index?
  end

  def new?
    index?
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
