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

ActiveRecord::Schema.define(version: 20180817031503) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "name"
    t.string "password_digest"
    t.string "email"
    t.string "username"
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "business_id"
    t.string "avatar"
    t.string "uid"
    t.string "provider"
    t.string "provider_image"
    t.string "player_id"
    t.index ["business_id"], name: "index_accounts_on_business_id"
    t.index ["email"], name: "index_accounts_on_email", unique: true
    t.index ["player_id"], name: "index_accounts_on_player_id"
    t.index ["provider"], name: "index_accounts_on_provider"
    t.index ["uid"], name: "index_accounts_on_uid", unique: true
    t.index ["username"], name: "index_accounts_on_username", unique: true
  end

  create_table "businesses", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.float "latitude"
    t.float "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "logo"
    t.string "cover_image"
    t.index ["name"], name: "index_businesses_on_name", unique: true
  end

  create_table "engagements", force: :cascade do |t|
    t.bigint "listing_id"
    t.bigint "business_id"
    t.integer "sender_id"
    t.integer "recipient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_id"], name: "index_engagements_on_business_id"
    t.index ["listing_id"], name: "index_engagements_on_listing_id"
    t.index ["recipient_id"], name: "index_engagements_on_recipient_id"
    t.index ["sender_id"], name: "index_engagements_on_sender_id"
  end

  create_table "images", force: :cascade do |t|
    t.string "listing_image"
    t.bigint "listing_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["listing_id"], name: "index_images_on_listing_id"
  end

  create_table "listings", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "address"
    t.decimal "price", precision: 8, scale: 2
    t.boolean "featured", default: false
    t.float "latitude"
    t.float "longitude"
    t.boolean "is_rental", default: false
    t.bigint "account_id"
    t.bigint "business_id"
    t.string "district"
    t.index ["account_id"], name: "index_listings_on_account_id"
    t.index ["business_id"], name: "index_listings_on_business_id"
    t.index ["district"], name: "index_listings_on_district"
    t.index ["latitude"], name: "index_listings_on_latitude"
    t.index ["longitude"], name: "index_listings_on_longitude"
  end

  create_table "messages", force: :cascade do |t|
    t.text "body"
    t.bigint "engagement_id"
    t.bigint "account_id"
    t.boolean "read", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "recipient_id"
    t.index ["account_id"], name: "index_messages_on_account_id"
    t.index ["engagement_id"], name: "index_messages_on_engagement_id"
    t.index ["recipient_id"], name: "index_messages_on_recipient_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.string "contact_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "business_id"
    t.string "username"
    t.index ["business_id"], name: "index_users_on_business_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "accounts", "businesses"
  add_foreign_key "engagements", "businesses"
  add_foreign_key "engagements", "listings"
  add_foreign_key "images", "listings"
  add_foreign_key "listings", "accounts"
  add_foreign_key "listings", "businesses"
  add_foreign_key "messages", "accounts"
  add_foreign_key "messages", "engagements"
  add_foreign_key "users", "businesses"
end
