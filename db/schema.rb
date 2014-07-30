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

ActiveRecord::Schema.define(version: 20140729223503) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: true do |t|
    t.string   "addressline1"
    t.string   "addressline2"
    t.string   "city"
    t.string   "state_abbrv"
    t.integer  "zipcode"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: true do |t|
    t.string   "title"
    t.integer  "location_id"
    t.integer  "event_type"
    t.date     "begin_date"
    t.date     "end_date"
    t.decimal  "registration_cost"
    t.date     "registration_open_date"
    t.date     "registration_close_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "events", ["location_id"], name: "location_id_ix", using: :btree

  create_table "events_hospitalities", id: false, force: true do |t|
    t.integer "event_id"
    t.integer "hospitality_id"
  end

  add_index "events_hospitalities", ["event_id", "hospitality_id"], name: "index_events_hospitalities_on_event_id_and_hospitality_id", using: :btree

  create_table "hospitalities", force: true do |t|
    t.string  "name"
    t.text    "description"
    t.string  "address1"
    t.string  "address2"
    t.string  "city"
    t.string  "state_abbrv"
    t.integer "zipcode"
    t.string  "hospitality_type"
    t.integer "locality_id"
    t.string  "max_capacity"
    t.string  "min_capacity"
  end

  create_table "localities", force: true do |t|
    t.string   "city"
    t.string   "state_abbrv"
    t.integer  "contact_id"
    t.integer  "hospitality_contact_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state_abbrv"
    t.integer  "zipcode"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "max_capacity"
  end

  create_table "registrations", force: true do |t|
    t.string   "payment_type"
    t.boolean  "has_been_paid"
    t.decimal  "payment_adjustment"
    t.boolean  "attend_as_serving_one"
    t.integer  "user_id"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "registrations", ["event_id"], name: "index_registrations_on_event_id", using: :btree
  add_index "registrations", ["user_id"], name: "index_registrations_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "name"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role"
    t.integer  "locality_id"
    t.decimal  "home_phone"
    t.decimal  "cell_phone"
    t.decimal  "work_phone"
    t.date     "birthday"
    t.integer  "hospitality_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["hospitality_id"], name: "index_users_on_hospitality_id", using: :btree
  add_index "users", ["locality_id"], name: "index_users_on_locality_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
