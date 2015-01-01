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

  def full_address(addressable)
    address = addressable.address1 + ' '
    address += addressable.address2 unless addressable.address2.nil?
    address += addressable.city + ', ' +
      addressable.state_abbrv + ' ' +
      addressable.zipcode.to_s
    address
  end
end
