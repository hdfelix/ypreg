module EventsHelper
	def event_location(event)
		location = Location.find(event.location_id)
		html = ''
		content_tag(:address) do
			html << "#{location.address1} \n<br />\n #{location.city}, #{location.state_abbrv}  #{location.zipcode}"
		end
		html.html_safe
	end

	def event_dates(event)
		content_tag(:span,) do
			if (event.begin_date && event.end_date)
				"#{event.begin_date.strftime('%m/%d/%y')} - #{event.end_date.strftime('%m/%d/%y')}".html_safe
			else
				"TBA"
			end
		end
	end
	
	def event_registration_dates(event)
		content_tag(:span) do
			if (event.registration_open_date && event.registration_close_date)
				"#{ event.end_date.strftime('%m/%d/%y')} - #{event.registration_open_date.strftime('%m/%d/%y')}".html_safe
			else
				"TBA"
			end
		end
	end
	def already_registered?(event_id)
		binding.pry
		if current_user.registrations.where("id = ?",event_id)
			true
		else
			false
		end
	end
end
