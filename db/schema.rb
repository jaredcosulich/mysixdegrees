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

ActiveRecord::Schema.define(:version => 20110407224716) do

  create_table "connections", :force => true do |t|
    t.integer  "profile_id"
    t.integer  "to_profile_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "reason"
  end

  create_table "emailings", :force => true do |t|
    t.integer  "user_id"
    t.string   "email_name"
    t.text     "params"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "emailings", ["user_id"], :name => "index_emailings_on_user_id"

  create_table "link_clicks", :force => true do |t|
    t.integer  "link_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "link_clicks", ["link_id"], :name => "index_link_clicks_on_link_id"

  create_table "links", :force => true do |t|
    t.string   "source_type"
    t.integer  "source_id"
    t.string   "path"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "links", ["source_type", "source_id"], :name => "index_links_on_source_type_and_source_id"

  create_table "photos", :force => true do |t|
    t.integer  "profile_id"
    t.string   "title"
    t.text     "caption"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "profiles", :force => true do |t|
    t.integer  "user_id"
    t.string   "slug"
    t.string   "location"
    t.decimal  "lat",                  :precision => 9, :scale => 6
    t.decimal  "lng",                  :precision => 9, :scale => 6
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "photo_count"
    t.integer  "connected_to_count"
    t.integer  "connected_from_count"
  end

  create_table "sharings", :force => true do |t|
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "user_tokens", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "token"
    t.string   "secret"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "nickname"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
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
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.string   "slug"
    t.string   "authentication_token"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["slug"], :name => "index_users_on_slug"

end
