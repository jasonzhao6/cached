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

ActiveRecord::Schema.define(:version => 20120311091931) do

  create_table "groups", :force => true do |t|
    t.integer "count", :default => 0
  end

  create_table "hash_tags", :force => true do |t|
    t.string  "hash_tag"
    t.integer "user_id"
  end

  add_index "hash_tags", ["hash_tag"], :name => "index_hash_tags_on_hash_tag", :unique => true

  create_table "tweets", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "tweet"
    t.integer  "hash_tag_id"
    t.integer  "group_id"
    t.integer  "user_id"
  end

  create_table "users", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
    t.string   "password_hash"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
