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

ActiveRecord::Schema.define(version: 20150327033601) do

  create_table "days", force: :cascade do |t|
    t.datetime "day"
    t.integer  "timesheet_id"
  end

  create_table "employees", force: :cascade do |t|
    t.string  "name"
    t.string  "email"
    t.string  "uid"
    t.boolean "admin"
  end

  add_index "employees", ["uid"], name: "index_employees_on_uid", unique: true

  create_table "in_and_outs", force: :cascade do |t|
    t.integer  "day_id"
    t.datetime "in"
    t.datetime "out"
  end

  create_table "payperiods", force: :cascade do |t|
    t.datetime "start_date"
    t.datetime "end_date"
  end

  create_table "posts", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "supervisors", force: :cascade do |t|
    t.integer "employee_id"
    t.integer "supervisor_id"
  end

  create_table "timesheets", force: :cascade do |t|
    t.integer "payperiod_id"
    t.integer "employee_id"
  end

end
