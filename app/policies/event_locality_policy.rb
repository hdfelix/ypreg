class EventLocalityPolicy < ApplicationPolicy

  class Scope < Scope
    def resolve
      if user.admin?
        scope
      elsif user.locality_contact?
        scope.where(id: user.locality_id)
      end
    end
  end

  def index?
    user.admin? or user.locality_contact?
  end

  def show?
    user.admin? or (user.locality_contact? and user.locality == record.locality)
  end

  def create?
    user.admin? or (user.locality_contact? and user.locality = record.locality)
  end

end
