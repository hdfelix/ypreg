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

ActiveRecord::Schema.define(version: 20151127185855) do

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
    t.integer  "event_type"
    t.date     "begin_date"
    t.date     "end_date"
    t.integer  "registration_cost"
    t.date     "registration_open_date"
    t.date     "registration_close_date"
    t.integer  "location_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description"
  end

  add_index "events", ["location_id"], name: "index_events_on_location_id", using: :btree

  create_table "events_localities", force: true do |t|
    t.integer "event_id"
    t.integer "locality_id"
    t.boolean "submitted_registration_payment_check", default: false
  end

  add_index "events_localities", ["event_id"], name: "index_events_localities_on_event_id", using: :btree
  add_index "events_localities", ["locality_id"], name: "index_events_localities_on_locality_id", using: :btree

  create_table "hospitalities", force: true do |t|
    t.integer "event_id"
    t.integer "lodging_id"
    t.integer "locality_id"
    t.integer "registration_id"
  end

  add_index "hospitalities", ["event_id"], name: "index_hospitalities_on_event_id", using: :btree
  add_index "hospitalities", ["locality_id"], name: "index_hospitalities_on_locality_id", using: :btree
  add_index "hospitalities", ["lodging_id"], name: "index_hospitalities_on_lodging_id", using: :btree
  add_index "hospitalities", ["registration_id"], name: "index_hospitalities_on_registration_id", using: :btree

  create_table "hospitality_registration_assignments", force: true do |t|
    t.integer "hospitality_id"
    t.integer "registration_id"
    t.integer "locality_id"
    t.integer "event_id"
  end

  add_index "hospitality_registration_assignments", ["event_id"], name: "index_hospitality_registration_assignments_on_event_id", using: :btree
  add_index "hospitality_registration_assignments", ["hospitality_id", "registration_id", "locality_id"], name: "hosp_assignmts", unique: true, using: :btree
  add_index "hospitality_registration_assignments", ["hospitality_id"], name: "index_hospitality_registration_assignments_on_hospitality_id", using: :btree
  add_index "hospitality_registration_assignments", ["locality_id"], name: "index_hospitality_registration_assignments_on_locality_id", using: :btree
  add_index "hospitality_registration_assignments", ["registration_id"], name: "index_hospitality_registration_assignments_on_registration_id", using: :btree

  create_table "localities", force: true do |t|
    t.string   "city"
    t.string   "state_abbrv"
    t.integer  "contact_id"
    t.integer  "lodging_contact_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "localities", ["contact_id"], name: "index_localities_on_contact_id", using: :btree
  add_index "localities", ["lodging_contact_id"], name: "index_localities_on_lodging_contact_id", using: :btree

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
    t.integer "min_capacity"
    t.integer "max_capacity"
    t.integer "contact_person_id"
  end

  add_index "lodgings", ["contact_person_id"], name: "index_lodgings_on_contact_person_id", using: :btree
  add_index "lodgings", ["locality_id"], name: "index_lodgings_on_locality_id", using: :btree

  create_table "notes", force: true do |t|
    t.string  "content"
    t.integer "user_id"
    t.integer "event_id"
  end

  add_index "notes", ["event_id"], name: "index_notes_on_event_id", using: :btree
  add_index "notes", ["user_id"], name: "index_notes_on_user_id", using: :btree

  create_table "pg_search_documents", force: true do |t|
    t.text     "content"
    t.integer  "searchable_id"
    t.string   "searchable_type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "pg_search_documents", ["searchable_id", "searchable_type"], name: "index_pg_search_documents_on_searchable_id_and_searchable_type", using: :btree

  create_table "registrations", force: true do |t|
    t.string   "payment_type"
    t.boolean  "has_been_paid"
    t.integer  "payment_adjustment"
    t.boolean  "attend_as_serving_one"
    t.integer  "user_id"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "hospitality_id"
    t.integer  "locality_id"
    t.boolean  "has_medical_release_form"
    t.string   "status"
    t.boolean  "conference_guest",         default: false
  end

  add_index "registrations", ["event_id"], name: "index_registrations_on_event_id", using: :btree
  add_index "registrations", ["hospitality_id"], name: "index_registrations_on_hospitality_id", using: :btree
  add_index "registrations", ["locality_id"], name: "index_registrations_on_locality_id", using: :btree
  add_index "registrations", ["user_id"], name: "index_registrations_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",      null: false
    t.string   "encrypted_password",     default: "",      null: false
    t.string   "name"
    t.integer  "locality_id"
    t.integer  "lodgings_id"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,       null: false
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
    t.string   "role",                   default: "guest"
    t.string   "home_phone"
    t.string   "cell_phone"
    t.string   "work_phone"
    t.date     "birthday"
    t.string   "gender"
    t.datetime "background_check_date"
    t.string   "grade"
    t.string   "age"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["locality_id"], name: "index_users_on_locality_id", using: :btree
  add_index "users", ["lodgings_id"], name: "index_users_on_lodgings_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
