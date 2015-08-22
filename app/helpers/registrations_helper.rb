module RegistrationsHelper
  def not_paid_in_words(has_been_paid)
    "NOT PAID" unless has_been_paid == true
  end
end
