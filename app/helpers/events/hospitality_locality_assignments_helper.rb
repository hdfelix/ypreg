module Events::HospitalityLocalityAssignmentsHelper
  def selected_locality(hospitality)
    ret = []
    if hospitality.locality.nil?
      ret = ["",""]
    else
      ret = [hospitality.locality.id.to_s,hospitality.locality.city]
    end
    binding.pry
    ret
  end
end
