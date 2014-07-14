module ApplicationHelper
	def format_date(date)
		if date
			date.strftime("%m/%d/%y")
		else
			'--'
		end
	end
end
