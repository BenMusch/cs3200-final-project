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

ActiveRecord::Schema.define(version: 20151130183508) do

  create_table "competed_ats", force: :cascade do |t|
    t.integer  "team_id",       limit: 4
    t.integer  "break_round",   limit: 4
    t.integer  "tournament_id", limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "competed_ats", ["team_id"], name: "index_competed_ats_on_team_id", using: :btree
  add_index "competed_ats", ["tournament_id"], name: "index_competed_ats_on_tournament_id", using: :btree

  create_table "debated_ats", force: :cascade do |t|
    t.string   "debater",              limit: 255
    t.integer  "speaker_award",        limit: 4
    t.integer  "novice_speaker_award", limit: 4
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "tournament_id",        limit: 4
  end

  add_index "debated_ats", ["tournament_id"], name: "index_debated_ats_on_tournament_id", using: :btree

  create_table "debaters", id: false, force: :cascade do |t|
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "name",        limit: 255, null: false
    t.boolean  "novice"
    t.boolean  "hybrid"
    t.integer  "soty_points", limit: 4
    t.integer  "noty_points", limit: 4
  end

  add_index "debaters", ["name"], name: "index_debaters_on_name", unique: true, using: :btree

  create_table "team_pairings", force: :cascade do |t|
    t.integer  "team_id",    limit: 4
    t.string   "debater",    limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "teams", force: :cascade do |t|
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.integer  "team_id",     limit: 4
    t.integer  "toty_points", limit: 4
  end

  create_table "tournaments", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "team_count", limit: 4
    t.integer  "year",       limit: 4
  end

  add_foreign_key "competed_ats", "teams"
  add_foreign_key "competed_ats", "tournaments"
  add_foreign_key "debated_ats", "tournaments"
end
