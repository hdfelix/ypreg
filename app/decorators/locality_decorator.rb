class LocalityDecorator < Draper::Decorator
  delegate_all

  def format_phone_number(phone)
    return '--' if phone.nil?
    tmp = phone
    if tmp.length == 7
      tmp.insert(3, ') ').insert(0, '(')
    elsif tmp.length == 10
      tmp.insert(6, '-').insert(3, ') ').insert(0, '(')
    end
  end
end
