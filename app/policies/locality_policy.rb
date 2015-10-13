# Policies for locality restful actions
class LocalityPolicy < ApplicationPolicy
  def index?
    user.present? && (user.role?(:admin))
  end

  def new?
    index?
  end

  def show?
    index?
  end

  def edit?
    index?
  end

  def update?
    index?
  end

  def destroy?
    index?
  end
end
