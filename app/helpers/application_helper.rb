module ApplicationHelper

  def flash_class(level)
    case level
    when 'notice' then 'alert alert-info'
    when 'success' then 'alert alert-success'
    when 'error' then 'alert alert-error'
    when 'alert' then 'alert alert-error'
    else ''
    end
  end

=begin
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

  def shorten(string, from, to, ellipsis=false)
    if ellipsis
      string.slice(from,(to - 3)) + '...'
    else
      string.slice(from,to)
    end
  end
=end

end
