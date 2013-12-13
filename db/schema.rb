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

ActiveRecord::Schema.define(:version => 20131213043307) do

  create_table "bet_participations", :force => true do |t|
    t.integer  "bet_id",     :null => false
    t.integer  "user_id",    :null => false
    t.string   "status",     :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "bet_participations", ["bet_id"], :name => "index_bet_participations_on_bet_id"
  add_index "bet_participations", ["user_id"], :name => "index_bet_participations_on_user_id"

  create_table "bets", :force => true do |t|
    t.integer  "user_id",                           :null => false
    t.text     "terms",                             :null => false
    t.text     "wager"
    t.string   "status",     :default => "pending", :null => false
    t.boolean  "private",    :default => false,     :null => false
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  add_index "bets", ["user_id"], :name => "index_bets_on_user_id"

  create_table "comments", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.integer  "bet_id",     :null => false
    t.text     "text"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "comments", ["bet_id"], :name => "index_comments_on_bet_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "friendships", :force => true do |t|
    t.integer  "out_friend_id",                   :null => false
    t.integer  "in_friend_id",                    :null => false
    t.boolean  "pending_flag",  :default => true
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "friendships", ["in_friend_id", "out_friend_id"], :name => "index_friendships_on_in_friend_id_and_out_friend_id"
  add_index "friendships", ["in_friend_id"], :name => "index_friendships_on_in_friend_id"
  add_index "friendships", ["out_friend_id"], :name => "index_friendships_on_out_friend_id"

  create_table "users", :force => true do |t|
    t.string   "username",                 :null => false
    t.string   "password_digest",          :null => false
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
    t.string   "session_token",            :null => false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "profile_pic_file_name"
    t.string   "profile_pic_content_type"
    t.integer  "profile_pic_file_size"
    t.datetime "profile_pic_updated_at"
  end

  add_index "users", ["session_token"], :name => "index_users_on_session_token", :unique => true
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

end
