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

ActiveRecord::Schema.define(:version => 20111004212443) do

  create_table "categories", :force => true do |t|
    t.string   "category"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "posts_count"
  end

  add_index "categories", ["category"], :name => "index_categories_on_category", :unique => true

  create_table "category_to_posts", :force => true do |t|
    t.integer  "category_id"
    t.integer  "post_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "category_to_posts", ["category_id"], :name => "index_category_to_posts_on_category_id"
  add_index "category_to_posts", ["post_id"], :name => "index_category_to_posts_on_post_id"

  create_table "comment_statuses", :force => true do |t|
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comment_statuses", ["status"], :name => "index_comment_statuses_on_status", :unique => true

  create_table "comments", :force => true do |t|
    t.string   "author"
    t.string   "email"
    t.string   "website"
    t.text     "content"
    t.integer  "permission_id"
    t.integer  "status_id"
    t.integer  "reply_id"
    t.integer  "post_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ip_address"
  end

  create_table "permissions", :force => true do |t|
    t.string   "permission"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "level"
  end

  add_index "permissions", ["permission"], :name => "index_permissions_on_permission", :unique => true

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "categories_count"
    t.integer  "tags_count"
    t.integer  "comments_count"
  end

  create_table "tag_to_posts", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "post_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tag_to_posts", ["post_id"], :name => "index_tag_to_posts_on_post_id"
  add_index "tag_to_posts", ["tag_id"], :name => "index_tag_to_posts_on_tag_id"

  create_table "tags", :force => true do |t|
    t.string   "tag"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "posts_count"
  end

  add_index "tags", ["tag"], :name => "index_tags_on_tag", :unique => true

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "user_name"
    t.text     "bio"
    t.string   "website_url"
    t.integer  "permission_id",                         :default => 1
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["user_name"], :name => "index_users_on_user_name", :unique => true

end
