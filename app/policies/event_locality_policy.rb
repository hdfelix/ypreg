class EventLocalityPolicy < ApplicationPolicy

  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      elsif user.locality_contact?
        scope.where(id: user.locality_id)
      end
    end
  end

end
