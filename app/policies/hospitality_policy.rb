# Policies for hospitality restful actions
class HospitalityPolicy < ApplicationPolicy
  def index?
    user.present? && user.role?(:admin)
  end

  def manage?
    index?
  end

  def show?
    index?
  end

  def new?
    index?
  end

  def edit?
    index?
  end

  def update?
    index?
  end

  def create?
    index?
  end

  def destroy?
    index?
  end
end
