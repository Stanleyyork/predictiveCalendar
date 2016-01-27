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

ActiveRecord::Schema.define(version: 20160127063507) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "calendars", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "attendees_id"
    t.boolean  "attachments"
    t.boolean  "anyone_can_add_self"
    t.datetime "created"
    t.string   "creator"
    t.string   "description"
    t.datetime "end"
    t.boolean  "guests_can_invite_others"
    t.boolean  "guests_can_see_other_guests"
    t.integer  "gcal_event_id"
    t.string   "location"
    t.string   "organizer"
    t.datetime "original_start_time"
    t.boolean  "recurrence"
    t.integer  "recurring_event_id"
    t.string   "reminders"
    t.datetime "start"
    t.string   "status"
    t.string   "summary"
    t.datetime "update"
    t.string   "visibility"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
