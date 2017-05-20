class EventPolicy < ApplicationPolicy

  def permitted_attributes
    [:begin_date, :description, :end_date, :event_type, :location_id, :name, :registration_cost, :registration_open_date, :registration_close_date, :name]
  end

  def can_manage?
    #edit? || (policy(EventLodging).index? && policy(Registration).index?)
    role?(:admin, :scyp, :locality_contact)
  end

  def edit_locality_payments?
    update_locality_payments?
  end

  def update_locality_payments?
    sudo?
  end

  # == Database Ops ==
  def index?
    role?(:admin, :scyp, :locality_contact)
  end

  def show?
    role?(:admin, :scyp, :locality_contact, :speaking_brother)
  end

  def copy?
    sudo?
  end

  class Scope < Scope
    def resolve
      if sudo? || user.locality_contact?
        scope
      end
    end
  end
end
