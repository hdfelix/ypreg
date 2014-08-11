module ApplicationHelper
	def format_date(date)
		if date
			date.strftime("%m/%d/%y")
		else
			'--'
		end
	end

  def list_unassigned_lodgings
    ev = Event.find(params[:event_id])
    Lodging.where('id not in (?)', ev.lodging_ids)
  end
end
