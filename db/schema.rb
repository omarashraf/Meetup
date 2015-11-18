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

ActiveRecord::Schema.define(version: 20151115165925) do

  create_table "comments", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "content"
  end

  create_table "comments_users_and_posts", force: true do |t|
    t.integer  "user_id"
    t.integer  "post_id"
    t.integer  "comment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments_users_and_posts", ["comment_id"], name: "index_comments_users_and_posts_on_comment_id"
  add_index "comments_users_and_posts", ["post_id"], name: "index_comments_users_and_posts_on_post_id"
  add_index "comments_users_and_posts", ["user_id"], name: "index_comments_users_and_posts_on_user_id"

  create_table "communities", force: true do |t|
    t.string   "comName"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "communities", ["user_id"], name: "index_communities_on_user_id"

  create_table "community_events", force: true do |t|
    t.integer  "community_id"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "community_events", ["community_id"], name: "index_community_events_on_community_id"
  add_index "community_events", ["event_id"], name: "index_community_events_on_event_id"

  create_table "events", force: true do |t|
    t.string   "eventName"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "events", ["user_id"], name: "index_events_on_user_id"

  create_table "friendships", force: true do |t|
    t.integer  "user_request_sender_id"
    t.integer  "user_request_receiver_id"
    t.boolean  "accept"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "friendships", ["user_request_receiver_id"], name: "index_friendships_on_user_request_receiver_id"
  add_index "friendships", ["user_request_sender_id"], name: "index_friendships_on_user_request_sender_id"

  create_table "members", force: true do |t|
    t.integer  "community_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "members", ["community_id"], name: "index_members_on_community_id"
  add_index "members", ["user_id"], name: "index_members_on_user_id"

  create_table "posts", force: true do |t|
    t.integer  "user_sender_id"
    t.integer  "user_receiver_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "community_id"
    t.integer  "event_id"
  end

  add_index "posts", ["community_id"], name: "index_posts_on_community_id"
  add_index "posts", ["event_id"], name: "index_posts_on_event_id"
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
