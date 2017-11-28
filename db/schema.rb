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

ActiveRecord::Schema.define(version: 20171127145801) do

  create_table "bookings", force: :cascade do |t|
    t.string   "timeslot"
    t.date     "date"
    t.integer  "zone_id"
    t.integer  "user_id"
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.decimal  "price",      precision: 4, scale: 2
    t.string   "add_on"
    t.boolean  "rated",                              default: false
    t.boolean  "reviewed",                           default: false
    t.boolean  "confirmed",                          default: false
  end

  add_index "bookings", ["user_id"], name: "index_bookings_on_user_id"
  add_index "bookings", ["zone_id"], name: "index_bookings_on_zone_id"

  create_table "ratings", force: :cascade do |t|
    t.integer  "stars"
    t.integer  "client"
    t.integer  "sitter"
    t.integer  "booking_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "ratings", ["booking_id"], name: "index_ratings_on_booking_id"

  create_table "reviews", force: :cascade do |t|
    t.string   "details"
    t.integer  "booking_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "client"
    t.integer  "sitter"
  end

  add_index "reviews", ["booking_id"], name: "index_reviews_on_booking_id"
  add_index "reviews", ["client"], name: "index_reviews_on_client"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "name"
    t.integer  "role"
    t.boolean  "admin",                  default: false
    t.boolean  "vip",                    default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "zones", force: :cascade do |t|
    t.string   "name"
    t.string   "desc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
