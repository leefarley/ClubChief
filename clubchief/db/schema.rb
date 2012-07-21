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

ActiveRecord::Schema.define(:version => 20110909004800) do

  create_table "attendees", :force => true do |t|
    t.integer   "user_id"
    t.integer   "event_id"
    t.boolean   "attending",    :default => true
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "salt"
    t.string    "encrypted_id"
  end

  create_table "clubs", :force => true do |t|
    t.string    "name",           :null => false
    t.text      "description"
    t.integer   "sport_id"
    t.text      "street_address"
    t.text      "suburb"
    t.integer   "town_city_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "competition_applications", :force => true do |t|
    t.integer   "user_id",                            :null => false
    t.integer   "competition_id",                     :null => false
    t.boolean   "assiged_to_team", :default => false
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "competitions", :force => true do |t|
    t.string    "name",                                   :null => false
    t.timestamp "deadline",                               :null => false
    t.integer   "club_id",                                :null => false
    t.boolean   "competition_finshed", :default => false
    t.text      "description"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "events", :force => true do |t|
    t.string    "name",       :null => false
    t.text      "message",    :null => false
    t.timestamp "start_at",   :null => false
    t.timestamp "end_at",     :null => false
    t.integer   "team_id",    :null => false
    t.integer   "user_id",    :null => false
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "memberships", :force => true do |t|
    t.integer   "user_id",                       :null => false
    t.integer   "team_id",                       :null => false
    t.boolean   "admin",      :default => false
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  add_index "memberships", ["user_id", "team_id"], :name => "index_memberships_on_user_id_and_team_id", :unique => true

  create_table "notifications", :force => true do |t|
    t.string    "message",                       :null => false
    t.integer   "team_id"
    t.integer   "user_id"
    t.boolean   "send_email", :default => false
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "sports", :force => true do |t|
    t.string    "sport_name"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "teams", :force => true do |t|
    t.string    "name",                              :null => false
    t.integer   "club_id",                           :null => false
    t.boolean   "club_team",      :default => false
    t.integer   "competition_id"
    t.integer   "max_players"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "town_cities", :force => true do |t|
    t.string    "name"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string    "first_name",                            :null => false
    t.string    "last_name",                             :null => false
    t.string    "email",                                 :null => false
    t.string    "encrypted_password",                    :null => false
    t.string    "salt",                                  :null => false
    t.string    "student_id"
    t.string    "phone"
    t.string    "address"
    t.boolean   "verified",           :default => false
    t.boolean   "change_password",    :default => false
    t.string    "perishable_token",   :default => ""
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
