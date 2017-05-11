class RegistrationPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if sudo?
        scope
      elsif user.locality_contact?
        scope.joins(:event_locality).where(event_localities: {locality: user.locality})
      end
    end
  end
end
