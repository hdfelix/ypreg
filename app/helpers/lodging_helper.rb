module LodgingHelper 
  def contact_person_name(lodging)
    lodging.contact_person.name
  end

  def min_max_capacity(lodging)
    str = ""
    if lodging.min_capacity.nil?
      str = '-'
    else
      str = lodging.min_capacity.to_s
    end
    str += ' \ '
    if lodging.max_capacity.nil?
      str += '-'
    else
      str += lodging.max_capacity.to_s
    end
    str
  end
end
