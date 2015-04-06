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

ActiveRecord::Schema.define(version: 20150223112057) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "brands", force: true do |t|
    t.string   "name"
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "disks", force: true do |t|
    t.float    "width"
    t.float    "diameter_diska"
    t.integer  "bolt_count"
    t.float    "bolt_distance"
    t.float    "et"
    t.float    "diameter"
    t.integer  "brand_id"
    t.float    "price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "color"
  end

  create_table "marks", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "models", force: true do |t|
    t.string   "name"
    t.integer  "mark_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mods", force: true do |t|
    t.string   "name"
    t.integer  "mark_id"
    t.integer  "model_id"
    t.integer  "year_id"
    t.text     "sizes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "mods", ["mark_id"], name: "index_mods_on_mark_id", using: :btree
  add_index "mods", ["model_id"], name: "index_mods_on_model_id", using: :btree
  add_index "mods", ["year_id"], name: "index_mods_on_year_id", using: :btree

  create_table "pages", force: true do |t|
    t.text     "header"
    t.datetime "counter"
    t.string   "action"
    t.string   "phone"
    t.string   "address"
    t.string   "work_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sizes", force: true do |t|
    t.float    "width"
    t.float    "diameter"
    t.integer  "bolt_count"
    t.float    "bolt_distance"
    t.float    "et"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "mod_id"
    t.float    "di"
  end

  add_index "sizes", ["mod_id"], name: "index_sizes_on_mod_id", using: :btree

  create_table "tyre_sizes", force: true do |t|
    t.integer  "mod_id"
    t.float    "diameter"
    t.float    "width"
    t.float    "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tyre_sizes", ["mod_id"], name: "index_tyre_sizes_on_mod_id", using: :btree

  create_table "tyres", force: true do |t|
    t.float    "diameter"
    t.float    "width"
    t.float    "height"
    t.string   "full_name"
    t.integer  "price"
    t.string   "season"
    t.string   "brand_name"
    t.string   "name"
    t.string   "spikes"
    t.string   "speed"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "years", force: true do |t|
    t.integer  "year"
    t.integer  "mark_id"
    t.integer  "model_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "years", ["mark_id"], name: "index_years_on_mark_id", using: :btree
  add_index "years", ["model_id"], name: "index_years_on_model_id", using: :btree

end
