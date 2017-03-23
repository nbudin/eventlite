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

ActiveRecord::Schema.define(version: 20170323024936) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cms_files", id: :serial, force: :cascade do |t|
    t.string "parent_type"
    t.integer "parent_id"
    t.integer "uploader_id"
    t.string "file"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parent_type", "parent_id"], name: "index_cms_files_on_parent_type_and_parent_id"
    t.index ["uploader_id"], name: "index_cms_files_on_uploader_id"
  end

  create_table "cms_layouts", force: :cascade do |t|
    t.string "parent_type"
    t.bigint "parent_id"
    t.text "name"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "navbar_classes"
    t.index ["parent_type", "parent_id"], name: "index_cms_layouts_on_parent_type_and_parent_id"
  end

  create_table "events", id: :serial, force: :cascade do |t|
    t.text "name"
    t.datetime "start_time"
    t.integer "length_seconds"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug", null: false
    t.integer "root_page_id"
    t.bigint "default_cms_layout_id"
    t.index ["default_cms_layout_id"], name: "index_events_on_default_cms_layout_id"
    t.index ["root_page_id"], name: "index_events_on_root_page_id"
    t.index ["slug"], name: "index_events_on_slug", unique: true
  end

  create_table "navigation_items", id: :serial, force: :cascade do |t|
    t.text "title"
    t.integer "event_id"
    t.integer "parent_id"
    t.integer "page_id"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_navigation_items_on_event_id"
    t.index ["page_id"], name: "index_navigation_items_on_page_id"
    t.index ["parent_id"], name: "index_navigation_items_on_parent_id"
  end

  create_table "pages", id: :serial, force: :cascade do |t|
    t.text "name"
    t.string "slug"
    t.text "content"
    t.integer "parent_id"
    t.string "parent_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "cms_layout_id"
    t.index ["cms_layout_id"], name: "index_pages_on_cms_layout_id"
    t.index ["parent_type", "parent_id", "slug"], name: "index_pages_on_parent_type_and_parent_id_and_slug", unique: true
  end

  create_table "ticket_types", force: :cascade do |t|
    t.bigint "event_id"
    t.text "name"
    t.integer "price_cents", default: 0, null: false
    t.string "price_currency", default: "USD", null: false
    t.integer "number_available"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_ticket_types_on_event_id"
  end

  create_table "tickets", force: :cascade do |t|
    t.bigint "ticket_type_id"
    t.bigint "user_id"
    t.integer "payment_amount_cents", default: 0, null: false
    t.string "payment_amount_currency", default: "USD", null: false
    t.text "name"
    t.text "email"
    t.text "phone"
    t.text "stripe_customer_id"
    t.text "stripe_charge_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ticket_type_id"], name: "index_tickets_on_ticket_type_id"
    t.index ["user_id"], name: "index_tickets_on_user_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
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
    t.boolean "admin"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "cms_files", "users", column: "uploader_id"
  add_foreign_key "events", "cms_layouts", column: "default_cms_layout_id"
  add_foreign_key "events", "pages", column: "root_page_id"
  add_foreign_key "navigation_items", "events"
  add_foreign_key "navigation_items", "navigation_items", column: "parent_id"
  add_foreign_key "navigation_items", "pages"
  add_foreign_key "pages", "cms_layouts"
  add_foreign_key "ticket_types", "events"
  add_foreign_key "tickets", "ticket_types"
  add_foreign_key "tickets", "users"
end
