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

ActiveRecord::Schema.define(version: 20130922025838) do

  create_table "event_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "friends", force: true do |t|
    t.integer  "person_id"
    t.integer  "friend_id"
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
    t.string   "provider"
    t.string   "uid"
    t.string   "oauth_token"
    t.datetime "oauth_expires"
    t.string   "name"
    t.string   "image"
    t.string   "gender"
  end

  create_table "personal_records", force: true do |t|
    t.integer  "person_id"
    t.integer  "event_type_id"
    t.string   "event_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "url"
    t.string   "sub_cat"
    t.datetime "result_time"
    t.integer  "event_id"
    t.integer  "sub_event_id"
    t.boolean  "pr"
    t.integer  "record_id"
  end

  add_index "personal_records", ["person_id"], name: "index_personal_records_on_person_id"

end
