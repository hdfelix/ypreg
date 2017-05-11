# Policies for event restful actions
class EventPolicy < ApplicationPolicy

  def permitted_attributes
    [:event_type, :title, :begin_date, :end_date, :registration_cost,
     :registration_open_date, :registration_close_date, :location_id]
  end

  def can_manage?
    edit? || 
      (policy(EventLodging).index? &&
       policy(Registration).index?)
  end

  # == Database Ops ==
  def index?
    role?([:admin, :scyp, :locality_contact])
  end

  def show?
    role?([:admin, :scyp, :locality_contact, :speaking_brother])
  end

  def copy?
    sudo?
  end
end
