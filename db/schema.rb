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

ActiveRecord::Schema.define(version: 20150504195050) do

  create_table "courses", force: :cascade do |t|
    t.string   "name",             limit: 255
    t.date     "start"
    t.date     "finish"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "enrollment_token", limit: 4
  end

  create_table "courses_users", id: false, force: :cascade do |t|
    t.integer "user_id",   limit: 4
    t.integer "course_id", limit: 4
  end

  add_index "courses_users", ["course_id"], name: "index_courses_users_on_course_id", using: :btree
  add_index "courses_users", ["user_id"], name: "index_courses_users_on_user_id", using: :btree

  create_table "la_responses", force: :cascade do |t|
    t.text     "name",        limit: 65535
    t.integer  "question_id", limit: 4
    t.integer  "user_id",     limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "la_responses", ["question_id"], name: "index_la_responses_on_question_id", using: :btree
  add_index "la_responses", ["user_id"], name: "index_la_responses_on_user_id", using: :btree

  create_table "mc_answers", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.integer  "question_id", limit: 4
    t.boolean  "correct",     limit: 1
    t.integer  "order",       limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "mc_answers", ["question_id"], name: "index_mc_answers_on_question_id", using: :btree

  create_table "mc_responses", force: :cascade do |t|
    t.integer  "mc_answer_id", limit: 4
    t.integer  "user_id",      limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "mc_responses", ["mc_answer_id"], name: "index_mc_responses_on_mc_answer_id", using: :btree
  add_index "mc_responses", ["user_id"], name: "index_mc_responses_on_user_id", using: :btree

  create_table "num_answers", force: :cascade do |t|
    t.integer  "num",         limit: 4
    t.integer  "question_id", limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "num_answers", ["question_id"], name: "index_num_answers_on_question_id", using: :btree

  create_table "num_responses", force: :cascade do |t|
    t.integer  "num",           limit: 4
    t.integer  "num_answer_id", limit: 4
    t.integer  "user_id",       limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "num_responses", ["num_answer_id"], name: "index_num_responses_on_num_answer_id", using: :btree
  add_index "num_responses", ["user_id"], name: "index_num_responses_on_user_id", using: :btree

  create_table "organizations", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "questions", force: :cascade do |t|
    t.boolean  "active",     limit: 1,     default: false
    t.string   "category",   limit: 255
    t.text     "name",       limit: 65535
    t.integer  "order",      limit: 4
    t.integer  "session_id", limit: 4
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  add_index "questions", ["order"], name: "index_questions_on_order", using: :btree
  add_index "questions", ["session_id"], name: "index_questions_on_session_id", using: :btree

  create_table "sa_answers", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.integer  "question_id", limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "sa_answers", ["question_id"], name: "index_sa_answers_on_question_id", using: :btree

  create_table "sa_responses", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.integer  "sa_answer_id", limit: 4
    t.integer  "user_id",      limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "sa_responses", ["sa_answer_id"], name: "index_sa_responses_on_sa_answer_id", using: :btree
  add_index "sa_responses", ["user_id"], name: "index_sa_responses_on_user_id", using: :btree

  create_table "sessions", force: :cascade do |t|
    t.boolean  "active",     limit: 1,   default: false
    t.string   "name",       limit: 255
    t.date     "date"
    t.integer  "course_id",  limit: 4
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "sessions", ["course_id"], name: "index_sessions_on_course_id", using: :btree

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
    t.integer  "ogranization_id", limit: 4
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["ogranization_id"], name: "index_users_on_ogranization_id", using: :btree
  add_index "users", ["token"], name: "index_users_on_token", using: :btree

end
