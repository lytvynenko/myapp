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

ActiveRecord::Schema.define(:version => 20130527071705) do

  create_table "cn_charities", :force => true do |t|
    t.integer  "orgid"
    t.string   "charity_name"
    t.string   "city"
    t.string   "state"
    t.string   "category"
    t.string   "cause"
    t.string   "tag_line"
    t.string   "ein"
    t.float    "overallrtg"
    t.float    "overallscore"
    t.integer  "rank"
    t.boolean  "featured"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "cn_charity_lists", :force => true do |t|
    t.integer  "listid"
    t.string   "listname"
    t.integer  "typeid"
    t.string   "list_type"
    t.string   "rank"
    t.integer  "orgid"
    t.string   "charity_name"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "category"
    t.string   "charity_url"
    t.string   "category_slug"
    t.string   "value_label"
    t.string   "resource_uri"
    t.string   "value"
    t.string   "ein"
    t.text     "description"
  end

  create_table "cn_lists", :force => true do |t|
    t.integer  "listid"
    t.string   "listname"
    t.string   "description"
    t.integer  "typeid"
    t.string   "list_type"
    t.boolean  "show"
    t.integer  "show_order"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "resource_uri"
  end

  create_table "contacts", :force => true do |t|
    t.integer  "user_id"
    t.string   "type"
    t.string   "value"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "contacts", ["user_id"], :name => "index_contacts_on_user_id"

  create_table "crushes", :force => true do |t|
    t.integer  "user_id"
    t.float    "amount"
    t.string   "message"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "featured_charities", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "ein"
    t.string   "fg_uuid"
    t.integer  "cn_id"
    t.string   "image"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "fields", :force => true do |t|
    t.integer  "user_id"
    t.string   "type"
    t.string   "value"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "fields", ["user_id"], :name => "index_fields_on_user_id"

  create_table "profile_attributes", :force => true do |t|
    t.integer  "profile_id"
    t.string   "type"
    t.string   "value"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "profile_attributes", ["profile_id"], :name => "index_profile_attributes_on_profile_id"

  create_table "profiles", :force => true do |t|
    t.integer  "user_id"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "primary_email"
    t.string   "primary_mobile"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "profiles", ["user_id"], :name => "index_profiles_on_user_id"

  create_table "rails_admin_histories", :force => true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      :limit => 2
    t.integer  "year",       :limit => 5
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_rails_admin_histories"

  create_table "user_attributes", :force => true do |t|
    t.integer  "user_id"
    t.string   "type"
    t.string   "value"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "user_attributes", ["user_id"], :name => "index_user_attributes_on_user_id"

  create_table "user_data", :force => true do |t|
    t.integer  "user_id"
    t.string   "type"
    t.string   "value"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "user_data", ["user_id"], :name => "index_user_data_on_user_id"

  create_table "user_fields", :force => true do |t|
    t.integer  "user_id"
    t.string   "type"
    t.string   "value"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "user_fields", ["user_id"], :name => "index_user_fields_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "username"
    t.string   "provider"
    t.string   "uid"
    t.string   "User"
    t.boolean  "admin"
    t.string   "oauth_token"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
