module ApplicationHelper
	def format_date(date)
		if date
			date.strftime("%m/%d/%y")
		else
			'--'
		end
	end

  def list_unassigned_hospitalities
    ev = Event.find(params[:event_id])
    Hospitality.where('id not in (?)', ev.hospitality_ids)
  end
end
