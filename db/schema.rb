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

ActiveRecord::Schema.define(:version => 20110803091648) do

  create_table "answers", :force => true do |t|
    t.integer "user_id"
    t.integer "question_id"
    t.text    "content"
    t.string  "username"
    t.string  "me"
    t.binary  "comment_a_json"
    t.integer "created_at"
    t.integer "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", :force => true do |t|
    t.integer  "sender_id"
    t.integer  "receiver_id"
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notifications", :force => true do |t|
    t.integer  "user_id"
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "profiles", :force => true do |t|
    t.integer  "user_id"
    t.string   "asked_id_list"
    t.string   "subscribe_id_list"
    t.string   "collected_id_list"
    t.string   "follower_uid_list"
    t.string   "following_uid_list"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions", :force => true do |t|
    t.integer "user_id"
    t.string  "title"
    t.text    "content"
<<<<<<< HEAD
    t.integer "credit"
    t.integer "money"
=======
    t.string  "username"
>>>>>>> 临时以strings存储question
    t.string  "answer_id_list"
    t.binary  "comment_q_json"
    t.string  "follower_id_list"
    t.integer "created_at"
    t.integer "updated_at"
  end

  create_table "scores", :force => true do |t|
    t.integer  "user_id"
    t.integer  "question_id"
    t.integer  "answer_id"
    t.integer  "value"
    t.string   "remark"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transactions", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "realname"
    t.string   "username"
    t.string   "me"
    t.integer  "subscribe_count"
    t.integer  "following_count"
    t.integer  "follower_count"
    t.integer  "publish_q_count"
    t.integer  "publish_a_count"
    t.integer  "score",                                 :default => 0
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
