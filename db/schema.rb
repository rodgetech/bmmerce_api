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

ActiveRecord::Schema.define(version: 20180723001904) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "districts", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_districts_on_name", unique: true
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
    t.text "price_details"
    t.bigint "user_id"
    t.string "address"
    t.decimal "price", precision: 8, scale: 2
    t.boolean "featured", default: false
    t.bigint "district_id"
    t.string "contact_name"
    t.string "contact_email"
    t.string "contact_number"
    t.boolean "email_flag", default: true
    t.boolean "phone_call_flag", default: true
    t.boolean "sms_flag", default: true
    t.boolean "whatsapp_flag", default: true
    t.float "latitude"
    t.float "longitude"
    t.index ["district_id"], name: "index_listings_on_district_id"
    t.index ["user_id"], name: "index_listings_on_user_id"
  end

  create_table "rent_requests", force: :cascade do |t|
    t.string "name"
    t.string "contact_number"
    t.datetime "rent_date"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "listing_id"
    t.index ["listing_id"], name: "index_rent_requests_on_listing_id"
  end

  create_table "renters", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.string "contact_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_renters_on_email", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.string "contact_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "images", "listings"
  add_foreign_key "listings", "districts"
  add_foreign_key "listings", "users"
  add_foreign_key "rent_requests", "listings"
end
