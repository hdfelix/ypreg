module Events::LocalitiesHelper
  def display_event_lodging_assignment(reg)
    if reg.event_lodging.nil?
      '--'
    else
      reg.event_lodging.lodging.name
    end
  end

end
