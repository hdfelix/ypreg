class EventLocalityDecorator < ApplicationDecorator
  decorates_associations :event, :locality

  delegate :event, :locality 
  delegate :name, to: :event, prefix: true
  delegate :city, :state, to: :locality
  delegate :id, to: :locality, prefix: true

  def lodging_count
    object.event_lodgings.size
  end

  def spaces_available
    "#{object.lodgings.sum(:min_capacity)}/#{object.lodgings.sum(:max_capacity)}"
  end

  def paid?
    yes_no(object.paid?)
  end

  def registration_count
    object.registrations.size
  end

  def role_count(role)
    @role_counts = object.users.role_counts unless defined? @role_counts
    @role_counts[role].to_i
  end

  def serving_one_count
    object.registrations.serving_one.size
  end

end
