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

ActiveRecord::Schema.define(version: 20171127145143) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "city"
    t.string "country"
    t.string "crunchbase_uuid"
    t.string "crunchbase_url"
    t.string "homepage_domain"
    t.string "profile_image_url"
    t.string "linkedin_url"
    t.text "short_description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "company_teches", force: :cascade do |t|
    t.bigint "tech_id"
    t.bigint "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_company_teches_on_company_id"
    t.index ["tech_id"], name: "index_company_teches_on_tech_id"
  end

  create_table "leads", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "contact_id"
    t.string "status"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_leads_on_user_id"
  end

  create_table "teches", force: :cascade do |t|
    t.string "name"
    t.string "category"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_teches", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "tech_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tech_id"], name: "index_user_teches_on_tech_id"
    t.index ["user_id"], name: "index_user_teches_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "company_teches", "companies"
  add_foreign_key "company_teches", "teches"
  add_foreign_key "leads", "users"
  add_foreign_key "user_teches", "teches"
  add_foreign_key "user_teches", "users"
end
