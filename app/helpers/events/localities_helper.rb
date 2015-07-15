module Events::LocalitiesHelper
  def display_hospitality_assignment(reg) 
    if reg.hospitality.nil?
      '--'
    else
      reg.hospitality.lodging.name
    end
  end
end
