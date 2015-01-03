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
    Lodging.where('id not in (?)', ev.hospitalities.pluck(:lodging_id))
  end

  def full_address(addressable,*options_hash)
    address = addressable.address1 + ' '
    address += addressable.address2 unless addressable.address2.nil?
    address += '<br />' if options_hash.first[:two_lines]
    address += addressable.city + ', ' +
      addressable.state_abbrv + '&nbsp;&nbsp;' +
      addressable.zipcode.to_s
    address.html_safe
  end

  def format_phone_number(phone)
    tmp = phone
    if tmp.length == 7
      tmp.insert(3,') ').insert(0,'(')
    elsif tmp.length == 10
      tmp.insert(6,'-').insert(3,') ').insert(0,'(')
    end
  end
end
