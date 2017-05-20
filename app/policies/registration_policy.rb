class RegistrationPolicy < ApplicationPolicy

  def permitted_attributes
    [:guest, :event_lodging_id, :medical_release, :paid, :payment_adjustment, :payment_type,
     :serving_one, :status, :vehicle_seating_capacity]
  end

  def edit_lodging?
    sudo?
  end

  # == Database Ops ==
  def index?
    sudo? || user.locality_contact?
  end

  def show?
    if sudo?
      true
    elsif user.locality_contact?
      user.locality == record.locality
    else
      user == record.user
    end
  end

  def create?
    show?
  end

  def update?
    show?
  end

  def destroy?
    show?
  end

  class Scope < Scope
    def resolve
      if sudo?
        scope
      elsif user.locality_contact?
        scope.joins(:event_locality).where(event_localities: {locality_id: user.locality.id})
      end
    end
  end
end
