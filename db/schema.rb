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

ActiveRecord::Schema.define(version: 20151022151545) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string   "line1"
    t.string   "line2"
    t.string   "city"
    t.string   "state"
    t.integer  "zipcode"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "event_localities", force: :cascade do |t|
    t.integer  "event_id"
    t.integer  "locality_id"
    t.boolean  "paid",        default: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["event_id"], name: "index_event_localities_on_event_id", using: :btree
    t.index ["locality_id"], name: "index_event_localities_on_locality_id", using: :btree
  end

  create_table "event_lodgings", force: :cascade do |t|
    t.integer "event_id"
    t.integer "lodging_id"
    t.index ["event_id"], name: "index_event_lodgings_on_event_id", using: :btree
    t.index ["lodging_id"], name: "index_event_lodgings_on_lodging_id", using: :btree
  end

  create_table "events", force: :cascade do |t|
    t.date     "begin_date"
    t.string   "description"
    t.date     "end_date"
    t.integer  "event_type",              default: 0
    t.integer  "location_id"
    t.string   "name"
    t.date     "registration_close_date"
    t.integer  "registration_cost"
    t.date     "registration_open_date"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["location_id"], name: "index_events_on_location_id", using: :btree
  end

  create_table "hospitality_registration_assignments", force: :cascade do |t|
    t.integer "hospitality_id"
    t.integer "registration_id"
    t.integer "locality_id"
    t.integer "event_id"
    t.index ["event_id"], name: "index_hospitality_registration_assignments_on_event_id", using: :btree
    t.index ["hospitality_id", "registration_id", "locality_id"], name: "hosp_assignmts", unique: true, using: :btree
    t.index ["hospitality_id"], name: "index_hospitality_registration_assignments_on_hospitality_id", using: :btree
    t.index ["locality_id"], name: "index_hospitality_registration_assignments_on_locality_id", using: :btree
    t.index ["registration_id"], name: "index_hospitality_registration_assignments_on_registration_id", using: :btree
  end

  create_table "localities", force: :cascade do |t|
    t.string   "city"
    t.string   "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "locations", force: :cascade do |t|
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.text     "description"
    t.integer  "location_type", default: 0
    t.string   "name"
    t.string   "state"
    t.integer  "zipcode"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "max_capacity"
  end

  create_table "lodgings", force: :cascade do |t|
    t.text     "description"
    t.integer  "location_id"
    t.integer  "lodging_type", default: 0
    t.integer  "max_capacity"
    t.integer  "min_capacity"
    t.string   "name"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["location_id"], name: "index_lodgings_on_location_id", using: :btree
  end

  create_table "notes", force: :cascade do |t|
    t.string  "content"
    t.integer "user_id"
    t.integer "event_id"
    t.index ["event_id"], name: "index_notes_on_event_id", using: :btree
    t.index ["user_id"], name: "index_notes_on_user_id", using: :btree
  end

  create_table "pg_search_documents", force: :cascade do |t|
    t.text     "content"
    t.string   "searchable_type"
    t.integer  "searchable_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["searchable_type", "searchable_id"], name: "index_pg_search_documents_on_searchable_type_and_searchable_id", using: :btree
  end

  create_table "registrations", force: :cascade do |t|
    t.integer  "event_locality_id"
    t.integer  "event_lodging_id"
    t.boolean  "guest",                    default: false
    t.boolean  "medical_release",          default: false
    t.boolean  "paid",                     default: false
    t.integer  "payment_type",             default: 0
    t.integer  "payment_adjustment",       default: 0
    t.boolean  "serving_one",              default: false
    t.integer  "status"
    t.integer  "user_id"
    t.integer  "vehicle_seating_capacity"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.index ["event_locality_id"], name: "index_registrations_on_event_locality_id", using: :btree
    t.index ["event_lodging_id"], name: "index_registrations_on_event_lodging_id", using: :btree
    t.index ["user_id"], name: "index_registrations_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "name"
    t.integer  "locality_id"
    t.integer  "lodgings_id"
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
    t.integer  "role",                   default: 0
    t.integer  "age",                    default: 0
    t.string   "avatar"
    t.datetime "background_check_date"
    t.date     "birthday"
    t.string   "cell_phone"
    t.integer  "gender",                 default: 0
    t.integer  "grade",                  default: 0
    t.string   "home_phone"
    t.string   "work_phone"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["locality_id"], name: "index_users_on_locality_id", using: :btree
    t.index ["lodgings_id"], name: "index_users_on_lodgings_id", using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

end
