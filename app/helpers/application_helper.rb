module ApplicationHelper
  def format_date(date)
    if date
      date.strftime('%m/%d/%y')
    else
      '--'
    end
  end

  def list_unassigned_lodgings
    ev = Event.find(params[:event_id])
    Lodging.where('id not in (?)', ev.event_lodgings.pluck(:lodging_id))
  end

  def full_address(addressable, options={})
    two_lines = options[:two_lines] || false

    unless addressable.address1.nil?
      address = addressable.address1 + ' '
      address += addressable.address2 unless addressable.address2.nil?
      address += '<br />' if two_lines
      address += addressable.city + ', ' +
        addressable.state + '&nbsp;&nbsp;' +
        addressable.zipcode.to_s
      address.html_safe
    else
      '--'
    end
  end

  def format_phone_number(phone)
    unless phone.nil?
      tmp = phone
      if tmp.length == 7
        tmp.insert(3,') ').insert(0,'(')
      elsif tmp.length == 10
        tmp.insert(6,'-').insert(3,') ').insert(0,'(')
      end
      content_tag('span',link_to("#{ tmp }","tel:#{ tmp }"))
    else
      '--'
    end
  end

  def format_titleize(string)
    if string.nil?
      '--'
    else
      string.titleize
    end
  end

  def display_yes_no(boolean)
    boolean ? 'Yes':'No'
  end

  def display_boolean(boolean)
    if boolean == nil
      '--'
    else
      display_yes_no(boolean)
    end
  end

  def shorten(string, from, to, ellipsis=false)
    if ellipsis
      string.slice(from,(to - 3)) + '...'
    else
      string.slice(from,to)
    end
  end

  def background_check_date_with_warning(user, date)
    if user.background_check_valid?
      content_tag(:span,"#{format_date(date)}")
    else
      html = content_tag(:i, '',class: ['fa','fa-exclamation-triangle'])
      html += ' '
      html += content_tag(:span,content_tag(:strong,"#{format_date(date)}"))
      html += tag(:br)
      html += content_tag(:span, "(New Background Check needed to attend any event.)")
      html.html_safe
    end
  end
end
