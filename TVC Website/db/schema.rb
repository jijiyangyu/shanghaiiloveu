# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100213084820) do

  create_table "answers", :force => true do |t|
    t.integer  "user_id",     :null => false
    t.integer  "question_id", :null => false
    t.integer  "choice_id",   :null => false
    t.text     "answer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "answers", ["question_id"], :name => "index_answers_on_question_id"
  add_index "answers", ["user_id"], :name => "index_answers_on_user_id"

  create_table "choices", :force => true do |t|
    t.integer  "question_id",              :null => false
    t.integer  "choice_num",  :limit => 2, :null => false
    t.string   "body",                     :null => false
    t.text     "remark"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "choices", ["question_id"], :name => "index_choices_on_question_id"

  create_table "comments", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.string   "theme",      :null => false
    t.text     "idea"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["user_id"], :name => "index_comments_on_user_id", :unique => true

  create_table "headlines", :force => true do |t|
    t.string   "headline",   :null => false
    t.string   "title",      :null => false
    t.string   "address",    :null => false
    t.integer  "show_num"
    t.text     "remark"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "links", :force => true do |t|
    t.string   "title",      :null => false
    t.string   "address",    :null => false
    t.integer  "show_num"
    t.text     "remark"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "maps", :force => true do |t|
    t.string   "table",       :null => false
    t.string   "field",       :null => false
    t.integer  "question_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "maps", ["question_id"], :name => "index_maps_on_question_id"

  create_table "people", :force => true do |t|
    t.integer  "user_id",       :null => false
    t.string   "name",          :null => false
    t.string   "email"
    t.string   "cell"
    t.string   "qq"
    t.string   "msn"
    t.boolean  "sex",           :null => false
    t.date     "birthday",      :null => false
    t.string   "constellation", :null => false
    t.string   "job",           :null => false
    t.string   "field",         :null => false
    t.string   "status",        :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "people", ["user_id"], :name => "index_people_on_user_id", :unique => true

  create_table "pictures", :force => true do |t|
    t.string   "title"
    t.string   "home_address",   :null => false
    t.string   "banner_address", :null => false
    t.string   "owner"
    t.string   "remark"
    t.boolean  "black_or_white"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", :force => true do |t|
    t.string   "title",       :null => false
    t.string   "sidetitle",   :null => false
    t.string   "subtitle"
    t.string   "owner"
    t.string   "summary"
    t.text     "body"
    t.integer  "category_id", :null => false
    t.boolean  "to_post",     :null => false
    t.integer  "show_num"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions", :force => true do |t|
    t.integer  "sequence_num", :null => false
    t.text     "body",         :null => false
    t.text     "remark"
    t.boolean  "open_or_not",  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "questions", ["sequence_num"], :name => "index_questions_on_sequence_num", :unique => true

  create_table "resources", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.string   "time",       :null => false
    t.text     "resource"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "resources", ["user_id"], :name => "index_resources_on_user_id", :unique => true

  create_table "sessions", :force => true do |t|
    t.string   "sessid"
    t.text     "data"
    t.datetime "updated_at"
    t.datetime "created_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name",                              :null => false
    t.string   "password",                          :null => false
    t.string   "created_ip"
    t.string   "email"
    t.string   "salt"
    t.boolean  "administrative", :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["name"], :name => "index_users_on_name", :unique => true

  create_table "videos", :force => true do |t|
    t.string   "title",                             :null => false
    t.string   "video_address"
    t.string   "player_address"
    t.string   "image_address"
    t.string   "src_address"
    t.integer  "show_num"
    t.string   "owner"
    t.boolean  "film_or_not",                       :null => false
    t.boolean  "src_or_not",                        :null => false
    t.boolean  "home",           :default => false, :null => false
    t.text     "remark"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
