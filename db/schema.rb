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

ActiveRecord::Schema.define(version: 20131224170133) do

  create_table "user_tokens", force: true do |t|
    t.integer  "user_id"
    t.string   "token",      limit: 43
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_tokens", ["token"], name: "index_user_tokens_on_token", using: :btree
  add_index "user_tokens", ["user_id"], name: "index_user_tokens_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",               null: false
    t.string   "first_name",          null: false
    t.string   "last_name",           null: false
    t.string   "faculty_number"
    t.string   "user_type",           null: false
    t.string   "password_digest"
    t.datetime "password_reset_at"
    t.string   "password_reset_hash"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end
