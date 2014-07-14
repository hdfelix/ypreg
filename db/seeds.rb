# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'faker'

#Create 3 locations
3.times do
  Location.create(
    name: Faker::Name.name,
    description: Faker::Lorem.sentence,
    address1: Faker::Address.street_address,
    city: Faker::Address.city,
    state_abbrv: Faker::Address.state_abbr,
    zipcode: Faker::Address.zip_code,
    max_capacity: rand(200..2000).round(-1)
  )
end

#Create 5 localities
5.times do
  Locality.create(
    city: Faker::Address.city,
    state_abbrv: Faker::Address.state_abbr
  )
end

#Create hospitalities
#hospitality_type: Hospitality::HOSPITALITY_TYPE.sample

#Create Test event
tmp_date = Time.now + rand(1..3).months

Event.create(
  title: Faker::Lorem.words(1).first.capitalize + ' ' + Faker::Lorem.words(1).first.capitalize,
  event_type: rand(1..3),
  begin_date: tmp_date,
  end_date: (tmp_date + 3.days).strftime('%Y/%m/%d'),
  registration_open_date: (tmp_date - 1.month).strftime('%Y/%m/%d'),
  registration_close_date: (tmp_date - 1.month + 15.days).strftime('%Y/%m/%d'),
  registration_cost: rand(10..100).round(-1),
  location_id: rand(1..Location.all.count)
)


#Create an admin user
admin= User.new(
  name: 'Hector D Felix',
  email: 'hdfelix@gmail.com', 
  password: 'chiracha',
  password_confirmation: 'chiracha')

  admin.skip_confirmation!
  admin.save
  admin.update_attributes(role: 'admin')
  admin.update_attributes(locality_id: Locality.all.sample.id)

#create yp account
yp = User.new(
  name: 'YP User',
  email: 'yp_user@ypreg.com', 
  password: 'chiracha',
  password_confirmation: 'chiracha')

  yp.skip_confirmation!
  yp.save
  yp.update_attributes(role: 'yp')

scyp = User.new(
  name: 'SCYP User',
  email: 'scyp_user@ypreg.com', 
  password: 'chiracha',
  password_confirmation: 'chiracha')

  scyp.skip_confirmation!
  scyp.save
  scyp.update_attributes(role: 'scyp')

