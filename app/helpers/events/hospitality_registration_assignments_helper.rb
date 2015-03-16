module Events::HospitalityRegistrationAssignmentsHelper
  def selected_hospitality(saint)
    if saint.assigned_hospitality(@event).nil?
      ["",""]
    else
      hosp = saint.assigned_hospitality(@event)
      [hosp.id.to_s,Lodging.find(hosp.lodging_id).name]
    end
  end
end
