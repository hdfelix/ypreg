class LocalityDecorator < Draper::Decorator
  delegate_all

  def contact_name
    if contact.nil?
      '--'
    else
      contact.name
    end
  end

  def contact_with_email
    if contact.nil?
      '--'
    else
      contact = User.find(contact_id)
      "#{contact.name} (#{contact.email})"
    end
  end

  def contact_with_email_and_cell
    if contact.nil?
      '--'
    else
      contact_string = ''
      contact.cell_phone.nil? ? contact_string = ')' : contact_string << ", #{format_phone_number(contact.cell_phone)})"
      contact.email.nil? ? contact_string.prepend("#{contact.name} (") : contact_string.prepend("#{contact.name} (#{contact.email}")
      contact_string
    end
  end

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
