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

ActiveRecord::Schema.define(version: 20161019080919) do

  create_table "account_searchers", force: :cascade do |t|
    t.integer  "account_id"
    t.integer  "seatcher_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "accounts", force: :cascade do |t|
    t.integer  "invoice_no"
    t.integer  "room_no"
    t.integer  "price"
    t.integer  "extension"
    t.integer  "deposit"
    t.integer  "miscellaneous"
    t.text     "remark"
    t.date     "date"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.boolean  "day"
    t.boolean  "night"
    t.date     "account_date"
    t.integer  "cc"
    t.integer  "old_room"
    t.integer  "hr_use"
    t.integer  "hr_cc"
  end

  create_table "searchers", force: :cascade do |t|
    t.date     "search_from"
    t.date     "search_to"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "staffs", force: :cascade do |t|
    t.integer  "room_number"
    t.time     "time_in"
    t.time     "time_out"
    t.text     "name"
    t.text     "remark"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "staffsearches", force: :cascade do |t|
    t.date     "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
