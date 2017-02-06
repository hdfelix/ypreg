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

  def index?
    user.admin? or user.locality_contact?
  end

  def show?
    if user.admin?
      return true
    end
    user.locality_contact? and user.locality == record.locality
  end

  def create?
    show?
  end

  def new?
    index?
  end

  def update?
    show?
  end

  def scyp_edit?
    user.admin?
  end

end
