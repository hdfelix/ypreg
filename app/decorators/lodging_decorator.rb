class LodgingDecorator < Draper::Decorator
  delegate_all

  def min_max_capacity
    low = min_capacity ? min_capacity.to_s : '-'
    high = max_capacity ? max_capacity.to_s : '-'
    [low, high].join(' to ')
  end

  def display_address_in_address_block_format
    "#{address1}\n#{city}, #{state}  #{zipcode}"
  end

  def display_description
    if description.nil?
      '--'
    else
      description
    end
  end

  def address
    address1 + ' ' + city + ', ' + state + '  ' + zipcode.to_s
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
end
