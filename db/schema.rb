# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140308042301) do

  create_table "addresses", force: true do |t|
    t.string   "addressline1"
    t.string   "addressline2"
    t.string   "city"
    t.integer  "state_id"
    t.integer  "zipcode"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "addresses", ["state_id"], name: "state_id_ix"

  create_table "events", force: true do |t|
    t.string   "title"
    t.integer  "location_id"
    t.integer  "event_type_id"
    t.datetime "begin_date"
    t.datetime "end_date"
    t.decimal  "registration_cost"
    t.datetime "registration_open_date"
    t.datetime "registration_close_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "events", ["event_type_id"], name: "event_type_id_ix"
  add_index "events", ["location_id"], name: "location_id_ix"

  create_table "locations", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "address_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "locations", ["address_id"], name: "index_locations_on_address_id"

  create_table "registrations", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "states", force: true do |t|
    t.string   "name"
    t.string   "abbrv"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
