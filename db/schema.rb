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

ActiveRecord::Schema.define(:version => 20101203024606) do

  create_table "employments", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "geodatapins", :force => true do |t|
    t.string   "formatted_address"
    t.float    "lat"
    t.float    "lng"
    t.integer  "pindata_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "occupations", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pindatas", :force => true do |t|
    t.text     "body"
    t.string   "company"
    t.string   "joblocation"
    t.string   "education"
    t.integer  "occupation_id"
    t.integer  "employment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "valid_pin"
  end

  create_table "pins", :force => true do |t|
    t.string   "company"
    t.decimal  "latitude"
    t.decimal  "longitude"
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "syspindatas", :force => true do |t|
    t.string   "sitesrcid",  :default => "",    :null => false
    t.string   "dataurl"
    t.string   "datasrc"
    t.boolean  "geocook",    :default => false
    t.integer  "pindata_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "todos", :force => true do |t|
    t.string   "name"
    t.boolean  "finished"
    t.boolean  "defect"
    t.text     "body"
    t.date     "due"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "todotasks", :force => true do |t|
    t.string   "name"
    t.boolean  "fiished"
    t.boolean  "defect"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "",    :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "",    :null => false
    t.string   "password_salt",                       :default => "",    :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",                               :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
