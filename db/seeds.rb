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

start_time = Time.now
current_users_total = User.all.count
current_Localities_total = Locality.all.count
current_Lodgings_total = Lodging.all.count
current_events_total = Event.all.count
current_locations_total = Location.all.count

print "\n\nRunning seeds file...\n"

# Create 5 locations
count = 5
print "\nCreating #{count} Locations: "
count.times do
  Location.create(
    name: Faker::Name.location_name,
    description: Faker::Lorem.sentence,
    address1: Faker::Address.street_address,
    city: Faker::Address.ypreg_city,
    state_abbrv: Faker::Address.state_abbr,
    zipcode: Faker::Address.zip_code,
    max_capacity: rand(50..200).round(-1)
  )
  print '.'
end

# Create 10 localities
count = 10
print "\nCreating #{count} Localities: "
count.times do
  Locality.create(
    city: Faker::Address.ypreg_city,
    state_abbrv: Faker::Address.state_abbr
  )
  print '.'
end

# Create  3 Test events
count = 3
print "\nCreating #{count} Events: "
tmp_date = Time.now + rand(1..3).months

Event.create(
  title: Faker::Name.event_name + ' '+ Faker::Name.event_modifier + ' ' + Faker::Name.event_type,
  event_type: rand(1..2),
  begin_date: tmp_date,
  end_date: (tmp_date + 3.days).strftime('%Y/%m/%d'),
  registration_open_date: (tmp_date - 1.month).strftime('%Y/%m/%d'),
  registration_close_date: (tmp_date - 1.month + 15.days).strftime('%Y/%m/%d'),
  registration_cost: rand(10..100).round(-1),
  location_id: rand(1..Location.all.count)
)
print '.'

tmp_date = Time.now + rand(3..4).months

Event.create(
  title: Faker::Name.event_name + ' '+ Faker::Name.event_modifier + ' ' + Faker::Name.event_type,
  event_type: rand(1..3),
  begin_date: tmp_date,
  end_date: (tmp_date + 3.days).strftime('%Y/%m/%d'),
  registration_open_date: (tmp_date - 1.month).strftime('%Y/%m/%d'),
  registration_close_date: (tmp_date - 1.month + 15.days).strftime('%Y/%m/%d'),
  registration_cost: rand(10..100).round(-1),
  location_id: rand(1..Location.all.count)
)
print '.'

tmp_date = Time.now + rand(4..7).months

Event.create(
  title: Faker::Name.event_name + ' '+ Faker::Name.event_modifier + ' ' + Faker::Name.event_type,
  event_type: rand(1..3),
  begin_date: tmp_date,
  end_date: (tmp_date + 3.days).strftime('%Y/%m/%d'),
  registration_open_date: (tmp_date - 1.month).strftime('%Y/%m/%d'),
  registration_close_date: (tmp_date - 1.month + 15.days).strftime('%Y/%m/%d'),
  registration_cost: rand(10..100).round(-1),
  location_id: rand(1..Location.all.count)
)
print '.'

total_users = 0
print "\nCreating Users..."

# Create an admin user
print "\n  Admins (1): "
admin = User.new(
  name: 'Hector D. Felix',
  email: 'hdfelix@gmail.com',
  password: 'chiracha',
  password_confirmation: 'chiracha')

admin.skip_confirmation!
admin.update_attributes(role: 'admin')
admin.update_attributes(locality_id: Locality.all.sample.id)
admin.save

print "."

total_users =+ 1

# Create yp accounts
count = 100
print "\n  YP accounts (#{count}): "

for i in 1..(count + 1) do
  yp = User.new(
    name: "YP User#{i}",
    email: "yp_user#{i}@ypreg.com",
    password: 'chiracha',
    password_confirmation: 'chiracha')

  yp.skip_confirmation!
  yp.update_attributes(role: 'yp')
  yp.update_attributes(locality_id: Locality.all.sample.id)
  yp.save
  
  print '.'
end

total_users =+ count

# Create SCYP accounts
count = 5
print "\n  SCYP accounts(#{count}): "

for i in 1..(count + 1) do
  scyp = User.new(
    name: "SCYP User#{i}",
    email: "scyp_user#{i}@ypreg.com",
    password: 'chiracha',
    password_confirmation: 'chiracha')

  scyp.skip_confirmation!
  scyp.update_attributes(role: 'scyp')
  scyp.update_attributes(locality_id: Locality.all.sample.id)
  scyp.save

  print '.'
end

total_users =+ count

# Create lodgings
# lodging_type: Lodging::LODGING_TYPE.sample

count = 30
print "\nCreating #{count} lodgings: "
lodging = Lodging.new(
          name: 'Felixes',
          description: "Hector & Angela Felix's home",
          address1: '60 Georgetown',
          city: 'Irvine',
          state_abbrv: 'CA',
          zipcode: '92612',
          max_capacity: rand(3..5),
          min_capacity: rand(1..3),
          contact_person: User.where(email: 'hdfelix@gmail.com').first,
          locality: Locality.all.sample,
          lodging_type: 1)
lodging.save
print '.'

for i in 1..30 do  #not adding 1 to idx (added lodging above already)
  user = User.all.sample
  lodging = FactoryGirl.create(
    :lodging,
    name: "Lodging #{i}",
    contact_person: user,
    locality: user.locality)
  lodging.save
  print '.'
end

# Create event registrations
count = rand(0..total_users)
print "\nCreating #{count} event registrations: "

ev = Event.first
for i in 1..(count + 1) do
  reg = Registration.new(
          payment_type: 1,
          has_been_paid: [true, false].sample,
          payment_adjustment: ev.registration_cost - rand(0..ev.registration_cost),
          attend_as_serving_one: [true, false].sample,
          user_id: User.all.sample.id,
          event_id: ev.id)
  reg.save
  print '.'
end

puts "Summary"
puts "---------------------------------"
puts "Prior users count:      #{current_users_total}. Added #{User.all.count}."
puts "Prior localities count: #{current_Localities_total}. Added #{Locality.all.count}."
puts "Prior lodgings count:   #{current_Lodgings_total}. Added #{Lodging.all.count}."
puts "Prior events count:     #{current_events_total}. Added #{Event.all.count}."
puts "Prior locations count:  #{current_locations_total}. Added #{Location.all.count}."
puts "---------------------------------"
puts "\n\nFinished in #{Time.now - start_time} seconds...\n\n"
