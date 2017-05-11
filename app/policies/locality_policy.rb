# Policies for locality restful actions
class LocalityPolicy < ApplicationPolicy

  def index?
    role?([:admin, :scyp, :locality_contact])
  end

  def show?
    user.admin? || user.scyp? || (user.locality_contact? && user.locality == record)
  end

  class Scope < Scope
    def resolve
      if user.admin?
        scope
      elsif user.locality_contact?
        scope.where(id: user.locality_id)
      end
    end
  end

end
