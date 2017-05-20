class EventDecorator < ApplicationDecorator
  decorates_associations :event_localities, :event_lodgings

  delegate :event_type, :location, :name, :over?, :registration_open?

  def dates
    "#{format_date(object.begin_date)} - #{format_date(object.end_date)}"
  end

  def self.event_types
    Event.event_types.keys.map { |k| [k.titleize, k] }
  end

  def locality_count(event_locality)
    @locality_counts = object.registrations.event_locality_counts unless defined? @locality_counts
    @locality_counts[event_locality].to_i
  end

  def location_name
    location.nil? ? "TBD" : location.name
  end

  def max_capacity
    if location.nil? || location.max_capacity.nil?
      "N/A"
    else
      location.max_capacity
    end
  end

  def registration_close_date
    format_date(object.registration_close_date)
  end

  def registration_cost
    if object.registration_cost.nil?
      "TBA"
    else
      helpers.number_to_currency(object.registration_cost)
    end
  end

  def registration_count
    object.registrations.size
  end

  def registration_window
    "#{format_date(object.registration_open_date)} - #{format_date(object.registration_close_date)}"
  end

  def remaining_spaces
    max_capacity == "N/A" ? "N/A" : (max_capacity - registration_count)
  end

  def role_count(role)
    @role_counts = object.users.role_counts unless defined? @role_counts
    @role_counts[role].to_i
  end

  def serving_one_count
    object.registrations.serving_one.size
  end

  def ss_brother_count
    role_count('speaking_brother') + role_count('supporting_brother')
  end

end
