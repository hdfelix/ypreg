class LodgingDecorator < Draper::Decorator
  delegate_all

  def min_max_capacity(lodging)
    low = lodging.min_capacity ? lodging.min_capacity.to_s : '-'
    high = lodging.max_capacity ? lodging.max_capacity.to_s : '-'
    [low, high].join(' to ')
  end

  def display_address_in_address_block_format
    "#{address1}\n#{city}, #{state_abbrv}  #{zipcode}"
  end

  def display_description
    if description.nil?
      '--'
    else
      description
    end
  end

  def address
    address1 + ' ' + city + ', ' + state_abbrv + '  ' + zipcode.to_s
  end

  def display_min_capacity
    if min_capacity.nil?
      '--'
    else
      min_capacity
    end
  end

  def display_max_capacity
    if max_capacity.nil?
      '--'
    else
      max_capacity
    end
  end

  def lodging_type_name
    Lodging::LODGING_TYPE[lodging_type.to_i]
  end
end
