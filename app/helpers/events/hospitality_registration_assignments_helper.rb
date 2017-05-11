module Events::HospitalityRegistrationAssignmentsHelper
  def selected_event_lodging(saint)
    if saint.assigned_event_lodging(@event).nil?
      ["",""]
    else
      hosp = saint.assigned_event_lodging(@event)
      [hosp.id.to_s,Lodging.find(hosp.lodging_id).name]
    end
  end
end
