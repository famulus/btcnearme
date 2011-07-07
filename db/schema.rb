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

ActiveRecord::Schema.define(:version => 20110707210611) do

  create_table "locations", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", :force => true do |t|
    t.string   "buying_or_selling"
    t.string   "email"
    t.decimal  "lat"
    t.decimal  "lng"
    t.decimal  "quantity"
    t.text     "zip_code",          :limit => 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "token"
    t.datetime "token_timestamp"
    t.string   "country"
  end

  add_index "posts", ["lat"], :name => "index_posts_on_lat"
  add_index "posts", ["lng"], :name => "index_posts_on_lng"

end
