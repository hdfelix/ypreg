# Policies for registration restful actions
class RegistrationPolicy < ApplicationPolicy
  def index?
    user.present? && (user.role?(:admin) || user.role?(:scyp))
  end

  # TODO: testing... remove?
  def attendance_index?
    user.persent? && (user.role?(:admin))
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
