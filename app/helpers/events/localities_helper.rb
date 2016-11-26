module Events::LocalitiesHelper
  def display_hospitality_assignment(reg)
    if reg.hospitality.nil?
      '--'
    else
      reg.hospitality.lodging.name
    end
  end

  def calculate_payment(registration)
    return number_to_currency(0) if !registration.has_been_paid
    number_to_currency(@event.registration_cost - registration.payment_adjustment)
  end
end
