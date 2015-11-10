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

ActiveRecord::Schema.define(version: 20151110201104) do

  create_table "friendships", force: true do |t|
    t.integer  "user_request_sender_id"
    t.integer  "user_request_receiver_id"
    t.boolean  "accept"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "friendships", ["user_request_receiver_id"], name: "index_friendships_on_user_request_receiver_id"
  add_index "friendships", ["user_request_sender_id"], name: "index_friendships_on_user_request_sender_id"

  create_table "posts", force: true do |t|
    t.integer  "user_sender_id"
    t.integer  "user_receiver_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "posts", ["user_receiver_id"], name: "index_posts_on_user_receiver_id"
  add_index "posts", ["user_sender_id"], name: "index_posts_on_user_sender_id"

  create_table "users", force: true do |t|
    t.text     "f_name"
    t.text     "l_name"
    t.text     "location"
    t.integer  "year_of_birth"
    t.text     "gender"
    t.text     "profile_picture"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
