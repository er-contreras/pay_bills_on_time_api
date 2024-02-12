ActiveRecord::Schema[7.0].define(version: 2023_09_07_183825) do
  enable_extension "plpgsql"

  create_table "bill_notifications", force: :cascade do |t|
    t.bigint "bill_id"
    t.boolean "notification", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bills", force: :cascade do |t|
    t.string "name"
    t.string "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_bills_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "username"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "bill_notifications", "bills"
  add_foreign_key "bills", "users"
end
