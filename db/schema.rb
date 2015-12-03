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

ActiveRecord::Schema.define(version: 20151203045728) do

  create_table "competed_ats", force: :cascade do |t|
    t.integer  "team_id",            limit: 4
    t.integer  "tournament_id",      limit: 4
    t.integer  "break_round",        limit: 4
    t.integer  "novice_break_round", limit: 4
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "competed_ats", ["team_id"], name: "index_competed_ats_on_team_id", using: :btree
  add_index "competed_ats", ["tournament_id"], name: "index_competed_ats_on_tournament_id", using: :btree

  create_table "debated_ats", force: :cascade do |t|
    t.integer  "debater_id",    limit: 4
    t.integer  "tournament_id", limit: 4
    t.integer  "speaker_award", limit: 4
    t.integer  "novice_place",  limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "debated_ats", ["debater_id"], name: "index_debated_ats_on_debater_id", using: :btree
  add_index "debated_ats", ["tournament_id"], name: "index_debated_ats_on_tournament_id", using: :btree

  create_table "debater_stats", force: :cascade do |t|
    t.integer  "debater_id",  limit: 4
    t.integer  "year",        limit: 4
    t.boolean  "novice"
    t.integer  "soty_points", limit: 4
    t.integer  "noty_points", limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "debater_stats", ["debater_id"], name: "index_debater_stats_on_debater_id", using: :btree

  create_table "debaters", force: :cascade do |t|
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.string   "name",       limit: 255, default: "Test Person", null: false
    t.boolean  "hybrid"
  end

  create_table "pairings", force: :cascade do |t|
    t.integer  "team_id",    limit: 4
    t.integer  "debater_id", limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "pairings", ["debater_id"], name: "index_pairings_on_debater_id", using: :btree
  add_index "pairings", ["team_id"], name: "index_pairings_on_team_id", using: :btree

  create_table "team_stats", force: :cascade do |t|
    t.integer  "year",        limit: 4
    t.integer  "team_id",     limit: 4
    t.integer  "toty_points", limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "team_stats", ["team_id"], name: "index_team_stats_on_team_id", using: :btree

  create_table "teams", force: :cascade do |t|
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "team_id",    limit: 4
  end

  create_table "tournaments", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.integer  "year",         limit: 4
    t.integer  "team_count",   limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "novice_count", limit: 4
  end

  add_foreign_key "competed_ats", "teams", name: "competed_ats_team_id_fk"
  add_foreign_key "competed_ats", "tournaments", name: "competed_ats_tournament_id_fk"
  add_foreign_key "debated_ats", "debaters", name: "debated_ats_debater_id_fk"
  add_foreign_key "debated_ats", "tournaments", name: "debated_ats_tournament_id_fk"
  add_foreign_key "debater_stats", "debaters", name: "debater_stats_debater_id_fk"
  add_foreign_key "pairings", "debaters"
  add_foreign_key "pairings", "teams"
  add_foreign_key "team_stats", "teams", name: "team_stats_team_id_fk"
end
