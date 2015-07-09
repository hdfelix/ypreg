# Policies for lodging restful actions
class LodgingPolicy < ApplicationPolicy
  def index?
    user.present? && (user.role?(:admin) || user.role?(:scyp))
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

  def create?
    index?
  end
end
