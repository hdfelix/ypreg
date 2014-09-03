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

ActiveRecord::Schema.define(version: 20140818054348) do

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
    t.string   "description"
  end

  add_index "events", ["location_id"], name: "location_id_ix", using: :btree

  create_table "hospitalities", force: true do |t|
    t.integer "event_id"
    t.integer "lodging_id"
  end

  add_index "hospitalities", ["event_id", "lodging_id"], name: "index_hospitalities_on_event_id_and_lodging_id", using: :btree

  create_table "hospitality_assignments", force: true do |t|
    t.integer "hospitality_id"
    t.integer "registration_id"
  end

  add_index "hospitality_assignments", ["hospitality_id"], name: "index_hospitality_assignments_on_hospitality_id", using: :btree
  add_index "hospitality_assignments", ["registration_id"], name: "index_hospitality_assignments_on_registration_id", using: :btree

  create_table "localities", force: true do |t|
    t.string   "city"
    t.string   "state_abbrv"
    t.integer  "contact_id"
    t.integer  "lodging_contact_id"
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

  create_table "lodgings", force: true do |t|
    t.string  "name"
    t.text    "description"
    t.string  "address1"
    t.string  "address2"
    t.string  "city"
    t.string  "state_abbrv"
    t.integer "zipcode"
    t.string  "lodging_type"
    t.integer "locality_id"
    t.string  "max_capacity"
    t.string  "min_capacity"
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
    t.integer  "hospitalities_id"
  end

  add_index "registrations", ["event_id"], name: "index_registrations_on_event_id", using: :btree
  add_index "registrations", ["hospitalities_id"], name: "index_registrations_on_hospitalities_id", using: :btree
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
    t.integer  "lodging_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["locality_id"], name: "index_users_on_locality_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
