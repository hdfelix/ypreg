module Events::HospitalityLocalityAssignmentsHelper
  def selected_locality(hospitality)
    if hospitality.locality.nil?
      ['', '']
    else
      [hospitality.locality.id.to_s, hospitality.locality.city]
    end
  end
end
