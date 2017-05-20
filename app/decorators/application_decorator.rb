class ApplicationDecorator < Draper::Decorator
  def format_date(date)
    return date.strftime('%m/%d/%y') if date.present?
  end

  def format_phone_number(number)
    return if number.blank?
    nice_number = number.dup
    if number.length == 7
      nice_number.insert(3,') ').insert(0,'(')
    elsif number.length == 10
      nice_number.insert(6,'-').insert(3,') ').insert(0,'(')
    end
    #content_tag('span',link_to("#{ nice_number }","tel:#{ nice_number }"))
    nice_number
  end

  def yes_no(boolean)
    boolean ? 'Yes' : 'No'
  end

end
