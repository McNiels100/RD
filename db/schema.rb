# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_04_25_082429) do
  create_table "Devices", force: :cascade do |t|
    t.string "brand"
    t.string "device_type"
    t.integer "tat_neutral"
    t.integer "tat_unsatisfied"
    t.integer "tat_very_unsatisfied"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "inventories", force: :cascade do |t|
    t.integer "imei"
    t.string "serial"
    t.string "location"
    t.integer "repair_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.integer "status", default: 0
    t.string "brand"
    t.string "model_code"
    t.index ["repair_id"], name: "index_inventories_on_repair_id"
    t.index ["status"], name: "index_inventories_on_status"
  end

  create_table "repair_items", force: :cascade do |t|
    t.integer "repair_id", null: false
    t.integer "inventory_id", null: false
    t.decimal "unit_price"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["inventory_id"], name: "index_repair_items_on_inventory_id"
    t.index ["repair_id"], name: "index_repair_items_on_repair_id"
  end

  create_table "repair_statuses", force: :cascade do |t|
    t.integer "repair_id", null: false
    t.integer "status_id", null: false
    t.integer "user_id", null: false
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["repair_id"], name: "index_repair_statuses_on_repair_id"
    t.index ["status_id"], name: "index_repair_statuses_on_status_id"
    t.index ["user_id"], name: "index_repair_statuses_on_user_id"
  end

  create_table "repairs", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.integer "phone_number"
    t.string "brand"
    t.text "error_description"
    t.integer "imei"
    t.string "serial"
    t.string "model"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "order_number"
    t.string "device_type"
    t.string "locked_by"
    t.datetime "locked_at"
    t.string "model_code"
    t.index ["order_number"], name: "index_repairs_on_order_number", unique: true
  end

  create_table "sessions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "ip_address"
    t.string "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "statuses", force: :cascade do |t|
    t.string "name"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email_address", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "role"
    t.string "name"
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
  end

  add_foreign_key "inventories", "repairs"
  add_foreign_key "repair_items", "inventories"
  add_foreign_key "repair_items", "repairs"
  add_foreign_key "repair_statuses", "repairs"
  add_foreign_key "repair_statuses", "statuses"
  add_foreign_key "repair_statuses", "users"
  add_foreign_key "sessions", "users"
end
