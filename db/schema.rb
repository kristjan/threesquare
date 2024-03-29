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

ActiveRecord::Schema.define(:version => 20130105202926) do

  create_table "checkins", :force => true do |t|
    t.integer  "user_id",       :null => false
    t.string   "venue_id",      :null => false
    t.string   "foursquare_id", :null => false
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "checkins", ["user_id", "venue_id"], :name => "index_checkins_on_user_id_and_venue_id"

  create_table "foods", :force => true do |t|
    t.integer  "checkin_id",  :null => false
    t.string   "description", :null => false
    t.integer  "rating",      :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "foods", ["checkin_id"], :name => "index_foods_on_checkin_id"

  create_table "foursquare_users", :force => true do |t|
    t.string   "foursquare_id"
    t.string   "access_token"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "foursquare_users", ["foursquare_id"], :name => "index_foursquare_users_on_foursquare_id"

end
