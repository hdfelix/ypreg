class LodgingDecorator < Draper::Decorator
  delegate :description, :location, :max_capacity, :min_capacity, :name
  delegate :name, to: :location, prefix: true

  def self.lodging_types
    Lodging.lodging_types.keys.map { |k| [k.titleize, k] }
  end

  def lodging_type
    object.lodging_type.titleize
  end

  def min_max_capacity
    min = min_capacity.present? ? min_capacity : '-'
    max = max_capacity.present? ? max_capacity : '-'
    [min, max].join(' to ')
  end

  def address_in_block_format
    "#{address1}\n#{city}, #{state}  #{zipcode}"
  end

  def address
    address1 + ' ' + city + ', ' + state + '  ' + zipcode.to_s
  end

end
