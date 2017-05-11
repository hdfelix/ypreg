module Events::HospitalityLocalityAssignmentsHelper
  def selected_locality(event_lodging)
    if event_lodging.locality.nil?
      ['', '']
    else
      [event_lodging.locality.id.to_s, event_lodging.locality.city]
    end
  end
end
