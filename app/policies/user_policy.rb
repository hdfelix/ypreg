# Policies for user restful actions
class UserPolicy < ApplicationPolicy

  class Scope < Scope
    def resolve
      if user.admin?
        scope.includes(:locality).all
      elsif user.locality_contact?
        scope.includes(:locality).where(locality: user.locality)
      end
    end
  end

  def role_edit?
    user.admin? or user.locality_contact?
  end

  def index?
    user.admin? or user.locality_contact?
  end

  def show?
    create? or user == record
  end

  def create?
    if user.admin?
      return true
    elsif user.locality_contact?
      user.locality == record.locality and not record.admin?
    else
      false
    end
  end

  def new?
    user.admin? or user.locality_contact?
  end

  def update?
    show?
  end

  def destroy?
    show?
  end
end
