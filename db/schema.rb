# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_06_19_225731) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "currencies", force: :cascade do |t|
    t.string "symbol", null: false
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_currencies_on_name", unique: true
    t.index ["symbol"], name: "index_currencies_on_symbol", unique: true
  end

  create_table "depot_daily_balances", force: :cascade do |t|
    t.date "date", null: false
    t.bigint "depot_id", null: false
    t.float "cached_rate_value"
    t.bigint "previous_daily_balance_id"
    t.integer "cached_depot_total_in_cents"
    t.integer "cached_depot_total_by_rate_in_cents"
    t.integer "cached_difference_in_cents"
    t.integer "cached_difference_by_rate_in_cents"
    t.float "cached_difference_in_percentage"
    t.float "cached_difference_by_rate_in_percentage"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["depot_id"], name: "index_depot_daily_balances_on_depot_id"
    t.index ["previous_daily_balance_id"], name: "index_depot_daily_balances_on_previous_daily_balance_id"
  end

  create_table "depot_movements", force: :cascade do |t|
    t.bigint "depot_id", null: false
    t.bigint "total_cents"
    t.date "date", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "description"
    t.index ["date"], name: "index_depot_movements_on_date"
    t.index ["depot_id"], name: "index_depot_movements_on_depot_id"
  end

  create_table "depots", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "cached_total_cents", default: 0, null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "currency_id", null: false
    t.bigint "rate_id"
    t.bigint "latest_daily_balance_id"
    t.index ["currency_id"], name: "index_depots_on_currency_id"
    t.index ["latest_daily_balance_id"], name: "index_depots_on_latest_daily_balance_id"
    t.index ["rate_id"], name: "index_depots_on_rate_id"
    t.index ["user_id"], name: "index_depots_on_user_id"
  end

  create_table "rate_values", force: :cascade do |t|
    t.bigint "rate_id", null: false
    t.float "value", null: false
    t.date "date", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["rate_id"], name: "index_rate_values_on_rate_id"
  end

  create_table "rates", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "key", null: false
    t.bigint "currency_id", null: false
    t.bigint "to_currency_id", null: false
    t.index ["currency_id"], name: "index_rates_on_currency_id"
    t.index ["to_currency_id"], name: "index_rates_on_to_currency_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "username", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "depot_daily_balances", "depot_daily_balances", column: "previous_daily_balance_id"
  add_foreign_key "depot_daily_balances", "depots"
  add_foreign_key "depot_movements", "depots"
  add_foreign_key "depots", "currencies"
  add_foreign_key "depots", "depot_daily_balances", column: "latest_daily_balance_id"
  add_foreign_key "depots", "rates"
  add_foreign_key "depots", "users"
  add_foreign_key "rate_values", "rates"
  add_foreign_key "rates", "currencies"
  add_foreign_key "rates", "currencies", column: "to_currency_id"
end
