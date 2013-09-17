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

ActiveRecord::Schema.define(version: 20130916043751) do

  create_table "event_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "people", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.date     "birth_date"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "personal_records", force: true do |t|
    t.integer  "person_id"
    t.integer  "event_type_id"
    t.integer  "hour"
    t.integer  "min"
    t.integer  "sec"
    t.string   "event_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "personal_records", ["person_id"], name: "index_personal_records_on_person_id"

end
