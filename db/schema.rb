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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160508182646) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ad_genres", force: :cascade do |t|
    t.integer  "ad_id",      null: false
    t.integer  "genre_id",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "ad_genres", ["ad_id"], name: "index_ad_genres_on_ad_id", using: :btree
  add_index "ad_genres", ["genre_id"], name: "index_ad_genres_on_genre_id", using: :btree

  create_table "ads", force: :cascade do |t|
    t.string   "product",                        null: false
    t.string   "company",                        null: false
    t.text     "description",                    null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "title"
    t.string   "youtube"
    t.date     "year",                           null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "average_rate",       default: 0
  end

  add_index "ads", ["company"], name: "index_ads_on_company", using: :btree
  add_index "ads", ["product"], name: "index_ads_on_product", using: :btree

  create_table "favorites", force: :cascade do |t|
    t.integer  "ad_id",      null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "favorites", ["ad_id"], name: "index_favorites_on_ad_id", using: :btree
  add_index "favorites", ["user_id"], name: "index_favorites_on_user_id", using: :btree

  create_table "features", force: :cascade do |t|
    t.integer  "ad_id",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "features", ["ad_id"], name: "index_features_on_ad_id", unique: true, using: :btree

  create_table "genres", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "genres", ["name"], name: "index_genres_on_name", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                           null: false
    t.string   "password_digest",                 null: false
    t.string   "session_token",                   null: false
    t.boolean  "admin",           default: false, null: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "uid"
    t.string   "provider"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["session_token"], name: "index_users_on_session_token", unique: true, using: :btree

  create_table "views", force: :cascade do |t|
    t.integer  "rate",       default: 0, null: false
    t.integer  "user_id",                null: false
    t.integer  "ad_id",                  null: false
    t.string   "title"
    t.text     "review"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "views", ["ad_id"], name: "index_views_on_ad_id", using: :btree
  add_index "views", ["rate"], name: "index_views_on_rate", using: :btree
  add_index "views", ["user_id"], name: "index_views_on_user_id", using: :btree

end
