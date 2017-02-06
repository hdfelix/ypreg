# Policies for locality restful actions
class LocalityPolicy < ApplicationPolicy

  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      elsif user.locality_contact?
        scope.where(id: user.locality_id)
      end
    end
  end

  def index?
    user.admin? or user.locality_contact?
  end

  def show?
    user.admin? or (user.locality_contact? and user.locality == record)
  end

  def update?
    show?
  end

end
