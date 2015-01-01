module Events::HospitalityRegistrationAssignmentsHelper
  def selected_hospitality(saint,locality)
    if saint.assigned_hospitality(@event,locality).nil?
      ["",""]
    else
      hosp = saint.assigned_hospitality(@event,locality)
      [hosp.id.to_s,Lodging.find(hosp.lodging_id).name]
    end
  end
end
