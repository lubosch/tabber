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

ActiveRecord::Schema.define(:version => 20140308013942) do

  create_table "Heading_Word", :force => true do |t|
    t.integer  "word_id",     :null => false
    t.datetime "timestamp",   :null => false
    t.integer  "rank",        :null => false
    t.integer  "previous_id"
    t.text     "text",        :null => false
  end

  create_table "Keyword_Heading", :force => true do |t|
    t.integer "heading_id",                                              :null => false
    t.string  "text",       :limit => 250,                               :null => false
    t.decimal "rating",                    :precision => 3, :scale => 3, :null => false
  end

  create_table "Keyword_PDF", :force => true do |t|
    t.string   "text",      :limit => 250,                               :null => false
    t.integer  "pdf_id",                                                 :null => false
    t.datetime "timestamp",                                              :null => false
    t.decimal  "rating",                   :precision => 3, :scale => 3
  end

  create_table "Keyword_Word", :force => true do |t|
    t.string   "text",      :limit => 250,                               :null => false
    t.integer  "word_id",                                                :null => false
    t.datetime "timestamp",                                              :null => false
    t.decimal  "rating",                   :precision => 3, :scale => 3
  end

  create_table "Log_Movie", :force => true do |t|
    t.integer  "movie_id",    :null => false
    t.integer  "software_id", :null => false
    t.datetime "started",     :null => false
    t.datetime "ended"
    t.integer  "user_id"
  end

  create_table "Log_Software", :force => true do |t|
    t.integer  "software_id",                       :null => false
    t.datetime "timestamp",                         :null => false
    t.string   "softwareWindowName", :limit => 250, :null => false
    t.integer  "user_id"
  end

  add_index "Log_Software", ["timestamp", "user_id"], :name => "IX_Log_Software"

  create_table "Log_Song", :force => true do |t|
    t.integer  "song_id",     :null => false
    t.integer  "software_id", :null => false
    t.datetime "started",     :null => false
    t.datetime "ended"
    t.integer  "user_id"
  end

  create_table "Movie", :force => true do |t|
    t.string   "filename",    :limit => 250, :null => false
    t.string   "name",        :limit => 250, :null => false
    t.integer  "software_id",                :null => false
    t.datetime "timestamp"
    t.integer  "times",                      :null => false
    t.integer  "length",                     :null => false
  end

  create_table "PDF", :force => true do |t|
    t.string   "filename",    :limit => 250, :null => false
    t.datetime "timestamp",                  :null => false
    t.integer  "software_id",                :null => false
  end

  create_table "Software", :force => true do |t|
    t.string "name",     :limit => 250, :null => false
    t.string "process",  :limit => 250, :null => false
    t.string "filepath", :limit => 250, :null => false
  end

  create_table "Song", :force => true do |t|
    t.string  "fileName", :limit => 250, :null => false
    t.string  "name",     :limit => 250
    t.string  "artist",   :limit => 250
    t.string  "genre",    :limit => 250
    t.integer "length",   :limit => 8,   :null => false
  end

  create_table "Text_Word", :force => true do |t|
    t.integer  "word_id",   :null => false
    t.datetime "timestamp", :null => false
    t.text     "text",      :null => false
  end

  create_table "User", :force => true do |t|
    t.string  "name",              :limit => 250
    t.string  "email",             :limit => 250
    t.string  "pass",              :limit => 250
    t.text    "token"
    t.integer "annota_id"
    t.string  "pc_uniq",           :limit => 250, :null => false
    t.string  "persistence_token"
    t.string  "ip"
  end

  create_table "Word", :force => true do |t|
    t.string   "filePath",  :limit => 450, :null => false
    t.string   "name",      :limit => 250, :null => false
    t.datetime "timestamp",                :null => false
    t.integer  "user_id"
  end

  add_index "Word", ["id"], :name => "IX_Word", :unique => true

end
