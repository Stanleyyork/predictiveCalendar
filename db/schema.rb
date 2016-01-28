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

ActiveRecord::Schema.define(version: 20160128212749) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attendees", force: :cascade do |t|
    t.integer  "gcal_attendee_id"
    t.string   "email"
    t.string   "display_name"
    t.boolean  "organizer"
    t.boolean  "self"
    t.boolean  "resource"
    t.boolean  "optional"
    t.string   "response_status"
    t.string   "comment"
    t.integer  "additional_guests"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "event_id"
  end

  create_table "calendars", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "code"
    t.string   "refresh_token"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

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
    t.datetime "updated"
    t.string   "visibility"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.boolean  "creator_self"
    t.string   "organizer_name"
    t.string   "organizer_email"
    t.boolean  "organizer_self"
    t.string   "html_link"
    t.integer  "calendar_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
