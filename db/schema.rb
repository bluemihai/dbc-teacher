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

ActiveRecord::Schema.define(version: 20160323151112) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "challenges", force: :cascade do |t|
    t.string   "name"
    t.integer  "phase"
    t.integer  "week"
    t.string   "github_repo"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "cohorts", force: :cascade do |t|
    t.string   "name"
    t.string   "github_name"
    t.date     "phase_1_start"
    t.integer  "location_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "current_phase"
  end

  create_table "interactions", force: :cascade do |t|
    t.integer  "student_id"
    t.integer  "teacher_id"
    t.integer  "minutes"
    t.string   "topic"
    t.integer  "challenge_id"
    t.integer  "rating"
    t.text     "learned"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "locations", force: :cascade do |t|
    t.string   "city"
    t.string   "abbrev"
    t.string   "status"
    t.date     "starting"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "role"
    t.hstore   "github_hash"
    t.integer  "cohort_id"
    t.integer  "location_id"
    t.string   "github_login"
  end

end
