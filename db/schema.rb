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

ActiveRecord::Schema.define(version: 20150601195728) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "guests", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "phone",      null: false
    t.string   "email",      null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "keys", force: :cascade do |t|
    t.integer  "place_id",                         null: false
    t.datetime "start_date",                       null: false
    t.datetime "end_date",                         null: false
    t.integer  "guest_id",                         null: false
    t.datetime "used_at"
    t.string   "secret_url",                       null: false
    t.boolean  "requested",        default: false, null: false
    t.boolean  "unlimited_access", default: false, null: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "logs", force: :cascade do |t|
    t.text     "message",       null: false
    t.integer  "loggable_id"
    t.string   "loggable_type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "logs", ["loggable_type", "loggable_id"], name: "index_logs_on_loggable_type_and_loggable_id", using: :btree

  create_table "notifications", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "key_id",     null: false
    t.string   "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "places", force: :cascade do |t|
    t.text     "address",                       null: false
    t.string   "nickname",                      null: false
    t.integer  "admin_id",                      null: false
    t.boolean  "master_unlock", default: false, null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name",       null: false
    t.string   "last_name",        null: false
    t.string   "email",            null: false
    t.string   "password_digest",  null: false
    t.integer  "default_place_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

end
