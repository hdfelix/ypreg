class RegistrationDecorator < ApplicationDecorator
  decorates_associations :user

  delegate :event, :locality, :lodging, :vehicle_seating_capacity
  delegate :age, :background_check_date, :background_check_date_row_class, :background_check_date_bg_class, :cell_phone, :email, :grade, :gender, :name, :role, to: :user, prefix: true

  delegate :name, to: :event, prefix: true
  delegate :city, to: :locality, prefix: true
  delegate :name, to: :lodging, prefix: true, allow_nil: true

  def self.payment_types
    Registration.payment_types.keys.map { |k| [k.titleize, k] }
  end

  def cost
    object.event.registration_cost
  end

  def created_at
    format_date(object.created_at)
  end

  def guest?
    yes_no(object.guest)
  end

  def medical_release?
    yes_no(object.medical_release)
  end

  def paid?
    yes_no(object.paid)
  end

  def payment
    h.number_to_currency(object.payment)
  end

  def payment_adjustment
    h.number_to_currency(object.payment_adjustment)
  end
  
  def serving_one?
    yes_no(object.serving_one)
  end
end
