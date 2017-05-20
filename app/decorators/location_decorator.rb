class LocationDecorator < Draper::Decorator
  delegate :address1, :description, :max_capacity, :name

  def address
    "#{street_address} #{city_state_zip}"
  end

  def city_state_zip
    "#{object.city}, #{object.state} #{object.zipcode}"
  end

  def location_type
    object.location_type.titleize
  end
  
  def self.location_types
    Location.location_types.keys.map { |k| [k.titleize, k] }
  end

  def street_address
    "#{object.address1} #{object.address2}"
  end

end
