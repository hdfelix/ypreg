module LodgingHelper
  def contact_person_name(lodging)
    lodging.contact_person.name
  end

  def min_max_capacity(lodging)
    low = lodging.min_capacity ? lodging.min_capacity.to_s : '-'
    high = lodging.max_capacity ? lodging.max_capacity.to_s : '-'
    [low, high].join(' to ')
  end

  def filtered_contact_person_collection(assigned_contact_person)
    User.not_contact_persons.to_a << assigned_contact_person
  end
end
