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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120425053221) do

  create_table "admins", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "logo"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.string   "encrypted_password"
    t.string   "salt"
    t.boolean  "super",              :default => false
    t.string   "subdomain"
    t.text     "terms"
    t.string   "sponsor"
    t.text     "losemessage"
    t.text     "thankyou"
    t.string   "pagetitle"
    t.string   "background"
    t.string   "bgcolor"
    t.string   "fontcolor"
    t.string   "linkcolor"
    t.integer  "limit"
    t.string   "loser"
  end

  add_index "admins", ["email"], :name => "index_admins_on_email", :unique => true

  create_table "prizes", :force => true do |t|
    t.string   "name"
    t.text     "winmessage"
    t.text     "redeemmessage"
    t.string   "odds"
    t.integer  "inventory"
    t.string   "image"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "admin_id"
    t.float    "weight"
    t.string   "suremessage"
    t.integer  "expiry"
  end

  add_index "prizes", ["admin_id"], :name => "index_prizes_on_admin_id"

end
