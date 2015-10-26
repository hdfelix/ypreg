module RegistrationsHelper
  def not_paid_in_words(has_been_paid)
    'NOT PAID' unless has_been_paid == true
  end

  def add_alert_style?(user)
    if user.background_check_valid?
      ''
    else
      "style='background-color: pink;'".html_safe
    end
  end
end
