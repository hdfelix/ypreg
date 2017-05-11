# This file should contain all the record creation needed to seed the database
# with its default values.
# The data can then be loaded with the rake db:seed (or created alongside
# the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'faker'

# Utility functions ======================
def calculate_age(birthday)
  days_in_a_year = 365.25
  now = Time.now.to_date
  birthdate = birthday.to_date
  age = (((now - birthdate).to_i) / days_in_a_year).to_int
  case
    when age < 13 then :minor
    when age == 13 then :thirteen
    when age == 14 then :fourteen
    when age == 15 then :fifteen
    when age == 16 then :sixteen
    when age == 17 then :seventeen
    when age == 18 then :eighteen
    when age > 18 then :adult
  end
end

def calculate_grade(age)
  case
    when 11 then :sixth
    when 12 then :seventh
    when 13 then :eighth
    when 14 then :ninth
    when 15 then :tenth
    when 16 then :eleventh
    when 17 then :twelfth
    when 18 then [:college, :other].sample 
  end
end

# Start! ================================
print "\n\nRunning seeds file...\n"
start_time = Time.now
current_users_total = User.count
current_localities_total = Locality.count
current_lodgings_total = Lodging.count
current_events_total = Event.count
current_locations_total = Location.count

# Locations ==============================
count = 5
print "\nCreating #{count} Locations: "
oak_glen = Location.create(
  name: "Oak Glen",
  description: "Christian Conference Center",
  address1: "39364 Oak Glen Rd.",
  city: "Yucaipa",
  state: "CA",
  zipcode: 92399,
  max_capacity: 297,
)
count -= 1
print '.'
count.times do
  Location.create(
    name: Faker::Name.location_name,
    location_type: Location.location_types.values.sample,
    description: Faker::Lorem.sentence,
    address1: Faker::Address.street_address,
    city: Faker::Address.ypreg_city,
    state: Faker::Address.state,
    zipcode: Faker::Address.zip_code,
    max_capacity: rand(50..200).round(-1)
  )
  print '.'
end

# Localities =========================
print "\nCreating localities: "
locality_names = ['Anaheim', 'Cypress', 'Riverside', 'Fullerton', 'Huntington Beach', 'Irvine', 'San Juan Capistrano', 'San Diego', 'Orange', 'Bakersfield']
locality_names.each do |city|
  Locality.create(
    city: city,
    state: 'CA'
  )
  print '.'
end

# Events ==============================
print "\nCreating events: "
tmp_date = Time.now + rand(1..3).months
Event.create(
  title: Faker::Name.event_name + ' ' + Faker::Name.event_modifier + ' ' + Faker::Name.event_type,
  event_type: Event.event_types.values.sample,
  begin_date: tmp_date,
  end_date: (tmp_date + 3.days).strftime('%Y/%m/%d'),
  registration_open_date: Time.now.strftime('%Y/%m/%d'),
  registration_close_date: (tmp_date - 1.month + 15.days).strftime('%Y/%m/%d'),
  registration_cost: rand(10..100).round(-1),
  location: oak_glen,
)
print '.'

tmp_date = Time.now + rand(3..4).months
Event.create(
  title: Faker::Name.event_name + ' ' + Faker::Name.event_modifier + ' ' + Faker::Name.event_type,
  event_type: Event.event_types.values.sample,
  begin_date: tmp_date,
  end_date: (tmp_date + 3.days).strftime('%Y/%m/%d'),
  registration_open_date: (tmp_date - 1.month).strftime('%Y/%m/%d'),
  registration_close_date: (tmp_date - 1.month + 15.days).strftime('%Y/%m/%d'),
  registration_cost: rand(10..100).round(-1),
  location: Location.all.sample
)
print '.'

tmp_date = Time.now + rand(4..7).months
Event.create(
  title: Faker::Name.event_name + ' ' + Faker::Name.event_modifier + ' ' + Faker::Name.event_type,
  event_type: Event.event_types.values.sample,
  begin_date: tmp_date,
  end_date: (tmp_date + 3.days).strftime('%Y/%m/%d'),
  registration_open_date: (tmp_date - 1.month).strftime('%Y/%m/%d'),
  registration_close_date: (tmp_date - 1.month + 15.days).strftime('%Y/%m/%d'),
  registration_cost: rand(10..100).round(-1),
  location: Location.all.sample
)
print '.'

# Create completed event in the past
tmp_date = Time.now - rand(5..7).months
past_event = Event.create(
  title: Faker::Name.event_name + ' ' + Faker::Name.event_modifier + ' ' + Faker::Name.event_type,
  event_type: Event.event_types.values.sample,
  begin_date: tmp_date,
  end_date: (tmp_date + 3.days).strftime('%Y/%m/%d'),
  registration_open_date: (tmp_date - 1.month).strftime('%Y/%m/%d'),
  registration_close_date: (tmp_date - 1.month + 15.days).strftime('%Y/%m/%d'),
  registration_cost: rand(10..100).round(-1),
  location: Location.all.sample
)

# Users ==================================
total_users = 0
print "\nCreating Users..."
print "\n  Admins (2): "
birthday = 38.years.ago
admin = User.new(
  name: 'Hector D. Felix',
  email: 'hdfelix@gmail.com',
  cell_phone: '8888888888',
  gender: :brother,
  birthday: birthday,
  age: calculate_age(birthday),
  grade: :other,
  role: :admin,
  locality: Locality.all.sample,
  password: 'chiracha',
  password_confirmation: 'chiracha',
  background_check_date: Time.zone.now,
)
admin.skip_confirmation!
admin.save
print '.'
total_users += 1
birthday = 33.years.ago
admin2 = User.new(
  name: 'Developer Account',
  email: 'test@test.com',
  cell_phone: '8888888888',
  gender: User.genders.keys.sample,
  birthday: birthday,
  age: calculate_age(birthday),
  grade: :other,
  role: :admin,
  locality: Locality.all.sample,
  password: 'devaccount',
  password_confirmation: 'devaccount',
  background_check_date: Time.zone.now,
)
admin2.skip_confirmation!
admin2.save
print '.'
total_users += 1

count = 50
print "\n  YP accounts (#{count}): "
(1..count).each do |i|
  birthday = (13..18).to_a.sample.years.ago
  age = calculate_age(birthday)
  yp = User.new(
    name: "YP User#{i}",
    gender: User.genders.keys.sample,
    birthday: birthday, 
    age: age,
    grade: calculate_grade(age),
    role: :yp,
    email: "yp_user#{i}@ypreg.com",
    locality: Locality.all.sample,
    password: 'chiracha',
    password_confirmation: 'chiracha',
  )
  yp.skip_confirmation!
  yp.save
  print '.'
end
total_users += count

count = 5
print "\n  SCYP accounts(#{count}): "
(1..count).each do |i|
  birthday = (19..60).to_a.sample.years.ago
  scyp = User.new(
    name: "SCYP User#{i}",
    gender: User.genders.keys.sample,
    birthday: birthday,
    age: calculate_age(birthday),
    grade: [:college, :other].sample,
    role: :scyp,
    email: "scyp_user#{i}@ypreg.com",
    locality: Locality.all.sample,
    password: 'chiracha',
    password_confirmation: 'chiracha',
    background_check_date: (30..36).to_a.sample.months.ago,
  )
  scyp.skip_confirmation!
  scyp.save
  print '.'
end
total_users += count

count = 20
print "\n  Trainee accounts(#{count}): "
(1..count).each do |i|
  birthday = (20..30).to_a.sample.years.ago
  scyp = User.new(
    name: "SCYP User#{i}",
    gender: User.genders.keys.sample,
    birthday: birthday,
    age: calculate_age(birthday),
    grade: [:college, :other].sample,
    role: 'trainee',
    email: "trainee_user#{i}@ypreg.com",
    locality: Locality.all.sample,
    password: 'chiracha',
    password_confirmation: 'chiracha',
    background_check_date: (30..36).to_a.sample.months.ago,
  )
  scyp.skip_confirmation!
  scyp.save
  print '.'
end

count = 10
print "\n  YCAT accounts(#{count}): "
(1..count).each do |i|
  birthday = (20..45).to_a.sample.years.ago
  scyp = User.new(
    name: "YCAT User#{i}",
    gender: User.genders.keys.sample,
    birthday: birthday,
    age: calculate_age(birthday),
    grade: [:college, :other].sample,
    role: :ycat,
    email: "ycat_user#{i}@ypreg.com",
    locality: Locality.all.sample,
    password: 'chiracha',
    password_confirmation: 'chiracha',
    background_check_date: (30..36).to_a.sample.months.ago
  )
  scyp.skip_confirmation!
  scyp.save
  print '.'
end
total_users += count

# Lodgings =====================================
print "\nCreating lodgings: "
# Oak Glen Dorms
['Live', 'Valley', 'Blue', 'Red'].each do |dorm|
  (1..10).each do |i|
    Lodging.create(
      name: "#{dorm} Oak #{i}",
      location: oak_glen,
      lodging_type: :dorm,
      max_capacity: 5,
      description: "2 bunks, 1 roll-away",
    )
  end
end
# Oak Glen Rooms
('A'..'D').each do |c|
  Lodging.create(
    name: "Pine #{c}",
    location: oak_glen,
    lodging_type: :single_room,
    max_capacity: 7,
    description: "3 bunks, 1 roll-away or futon",
  )
end
('E'..'G').each do |c|
  Lodging.create(
    name: "Pine #{c}",
    location: oak_glen,
    lodging_type: :single_room,
    max_capacity: 6,
    description: "3 bunks",
  )
end

# Event Registrations ============================
count = rand(5..total_users)
print "\nCreating #{count} event registrations (per event): "
Event.all.each do |event|
  yp_count = (count * 0.60).to_i
  print"\n\tYP Registrations for #{event.title}: "
  # YP registrations
  yp_ids = User.limit(yp_count).where(role: :yp).pluck(:id)
  while !yp_ids.empty?
    user = User.find(yp_ids.delete(yp_ids.sample))
    el = EventLocality.find_or_create_by!(event: event, locality: user.locality)
    reg = Registration.new(
      event_locality: el,
      user: user, 
      payment_adjustment: event.registration_cost - rand(0..event.registration_cost),
    )
    reg.save
    print '.'
  end

  print "\n\tNon-YP registrations for #{event.title}: "
  # non-YP registrations
  non_yp_count = count - yp_count
  non_yp_ids = User.limit(non_yp_count).where.not(role: :yp).pluck(:id)
  while !non_yp_ids.empty?
    user = User.find(non_yp_ids.delete(non_yp_ids.sample))
    el = EventLocality.find_or_create_by!(event: event, locality: user.locality)
    reg = Registration.new(
      event_locality: el,
      user: user,
      payment_adjustment: event.registration_cost - rand(0..event.registration_cost),
    )
    reg.save
    print '.'
  end
end

past_event.registrations.each do |registration|
  registration.update_attributes(paid: true, status: :attended)
end

puts "\nSummary"
puts '---------------------------------'
puts "Prior users count:      #{current_users_total}. Added #{User.count}."
puts "Prior localities count: #{current_localities_total}. Added #{Locality.count}."
puts "Prior lodgings count:   #{current_lodgings_total}. Added #{Lodging.count}."
puts "Prior events count:     #{current_events_total}. Added #{Event.count}."
puts "Prior locations count:  #{current_locations_total}. Added #{Location.count}."
puts '---------------------------------'
puts "\n\nFinished in #{Time.now - start_time} seconds...\n\n"
