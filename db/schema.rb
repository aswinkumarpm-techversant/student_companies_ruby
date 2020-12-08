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

ActiveRecord::Schema.define(version: 2020_12_08_100900) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cash_in_histories", force: :cascade do |t|
    t.bigint "cash_management_table_id"
    t.decimal "revenues_amount", precision: 15, scale: 2
    t.decimal "equity_amount", precision: 15, scale: 2
    t.decimal "convertible_note_amount", precision: 15, scale: 2
    t.decimal "bank_debt_amount", precision: 15, scale: 2
    t.decimal "other_amount", precision: 15, scale: 2
    t.string "status", default: "Need to be calculated"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["cash_management_table_id"], name: "index_cash_in_histories_on_cash_management_table_id"
  end

  create_table "cash_management_tables", force: :cascade do |t|
    t.bigint "student_company_id"
    t.string "cash_in"
    t.string "cash_out"
    t.string "initial_cash"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["student_company_id"], name: "index_cash_management_tables_on_student_company_id"
  end

  create_table "cash_out_histories", force: :cascade do |t|
    t.bigint "cash_management_table_id"
    t.decimal "cogs_amount", precision: 15, scale: 2
    t.decimal "employees_amount", precision: 15, scale: 2
    t.decimal "services_amount", precision: 15, scale: 2
    t.decimal "operating_expenses_amount", precision: 15, scale: 2
    t.decimal "investments_amount", precision: 15, scale: 2
    t.string "status", default: "Need to be calculated"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["cash_management_table_id"], name: "index_cash_out_histories_on_cash_management_table_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "country"
    t.string "currency"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "jwt_denylist", force: :cascade do |t|
    t.string "jti", null: false
    t.datetime "exp", null: false
    t.index ["jti"], name: "index_jwt_denylist_on_jti"
  end

  create_table "student_companies", force: :cascade do |t|
    t.bigint "company_id"
    t.bigint "student_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_student_companies_on_company_id"
    t.index ["student_id"], name: "index_student_companies_on_student_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "first_name"
    t.string "last_name"
    t.string "role", default: "Student"
    t.string "avatar"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
