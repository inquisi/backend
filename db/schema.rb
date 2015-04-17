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

ActiveRecord::Schema.define(version: 20150417162013) do

  create_table "courses", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.date     "start"
    t.date     "finish"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "user_id",    limit: 4
  end

  create_table "organizations", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "questions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sessions", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.date     "date"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "course_id",  limit: 4
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name",      limit: 255
    t.string   "last_name",       limit: 255
    t.string   "email",           limit: 255
    t.string   "password_digest", limit: 255
    t.string   "token",           limit: 255
    t.string   "role",            limit: 255
    t.boolean  "trial",           limit: 1
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "organization_id", limit: 4
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["token"], name: "index_users_on_token", using: :btree

  create_table "users_courses", id: false, force: :cascade do |t|
    t.integer "user_id",   limit: 4
    t.integer "course_id", limit: 4
  end

  add_index "users_courses", ["course_id"], name: "index_users_courses_on_course_id", using: :btree
  add_index "users_courses", ["user_id"], name: "index_users_courses_on_user_id", using: :btree

end
