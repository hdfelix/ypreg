desc "Create initial admin user for YPReg proejct"
namespace :ypreg do
	task create_admin: :environment do
		print "\n\n|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||"
		print "\nWelcome! This rake task will help you create an admin user to get started with YPReg.\n\n"
		print "First let's create your locality (e.g., if you meet with \nthe church in Anaheim, CA, create a locality for 'Anaheim, CA')\n"

		#output text colors
		warning_text_color = 93 #red
		success_text_color = 36 #cyan

		#text colorizing method
		def print_colored_text(text, color)
			print "\e[#{color}m#{text}\e[0m"
		end

		locality = {}

		puts "\n\nLocality name (e.g., 'Anaheim'): "
		print "> "

		locality["city"] = STDIN.gets.chomp

		puts "State Abbreviation ( e.g., 'CA'):"
		print "> "

		locality["abbrv"] = STDIN.gets.chomp

		#if loc = Locality.where("city = ? and state_abbrv = ?", locality["city"].capitalize, locality["abbrv"].upcase).first.presence

		loc = Locality.where("city = ? and state_abbrv = ?", locality["city"].capitalize, locality["abbrv"].upcase).first

		if loc.presence
			locality["locality_id"] = loc.id
			notice = "This locality is already in the database...\n"
			print_colored_text(notice, warning_text_color)
		else
			new_locality = Locality.new(city: locality["city"].capitalize, state_abbrv: locality["abbrv"].upcase)
			if new_locality.save
				locality["locality_id"] = new_locality.id
				notice = "'#{Locality.first.city}, #{Locality.first.state_abbrv}' created successfully.\n"
				print_colored_text(notice, success_text_color)
			else
				notice = "Error creating the new locality."
				print_colored_text(notice, warning_text_color)
			end
		end

		print "\nNow, let's create your admin user account:"

		user = {}

		puts "\nEnter your full name: "
		print "> "

		user["name"] = STDIN.gets.chomp

		puts "\nEnter your e-mail: "
		print "> "

		user["email"] = STDIN.gets.chomp

		puts "\nEnter your password that is more than 6 characters long: "
		print "(hidden) > "

		user["password"] = STDIN.noecho(&:gets).chomp

		if User.where("email = ?", user["email"]).first.presence
			notice = "\nThis user is already in the database...\n"
			print_colored_text(notice, warning_text_color)

		else
			new_user = User.new(name: user["name"].split.map(&:capitalize).join(' '), email: user["email"].downcase, password: user["password"], role: 'admin', locality_id: locality["locality_id"])
			if new_user.save
				notice = "\n#{new_user.name} (#{new_user.email}) created successfully."
				print_colored_text(notice, success_text_color)
			else
				notice = "Error creating the new admin user."
				print_colored_text(notice, warning_text_color)
			end
		end
		print "\n\n\n"	
  end
end
