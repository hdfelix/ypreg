# Policies for user restful actions
class UserPolicy < ApplicationPolicy
  def index?
    user.present? && (user.role?(:admin) || user.role?(:scyp))
  end

  def edit?
    index?
  end

  def new?
    index?
  end
end
