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

ActiveRecord::Schema.define(version: 2020_07_18_235837) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "currencies", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "symbol", null: false
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.uuid "currency_category_id", null: false
    t.index ["currency_category_id"], name: "index_currencies_on_currency_category_id"
    t.index ["name"], name: "index_currencies_on_name", unique: true
    t.index ["symbol"], name: "index_currencies_on_symbol", unique: true
  end

  create_table "currency_categories", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "depot_daily_balances", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.date "date", null: false
    t.uuid "depot_id", null: false
    t.float "cached_rate_value"
    t.uuid "previous_daily_balance_id"
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

  create_table "depot_movements", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "depot_id", null: false
    t.bigint "total_cents"
    t.date "date", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "description"
    t.index ["date"], name: "index_depot_movements_on_date"
    t.index ["depot_id"], name: "index_depot_movements_on_depot_id"
  end

  create_table "depots", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.bigint "cached_total_cents", default: 0, null: false
    t.uuid "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.uuid "currency_id", null: false
    t.uuid "rate_id"
    t.uuid "latest_daily_balance_id"
    t.datetime "deleted_at"
    t.index ["currency_id"], name: "index_depots_on_currency_id"
    t.index ["deleted_at"], name: "index_depots_on_deleted_at"
    t.index ["latest_daily_balance_id"], name: "index_depots_on_latest_daily_balance_id"
    t.index ["rate_id"], name: "index_depots_on_rate_id"
    t.index ["user_id"], name: "index_depots_on_user_id"
  end

  create_table "rate_values", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "rate_id", null: false
    t.float "value", null: false
    t.date "date", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["rate_id"], name: "index_rate_values_on_rate_id"
  end

  create_table "rates", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "key", null: false
    t.uuid "currency_id", null: false
    t.uuid "to_currency_id", null: false
    t.boolean "measured_in_currency", default: false
    t.index ["currency_id"], name: "index_rates_on_currency_id"
    t.index ["to_currency_id"], name: "index_rates_on_to_currency_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "username", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "currencies", "currency_categories"
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
