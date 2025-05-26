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

ActiveRecord::Schema[8.0].define(version: 2025_05_26_011028) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "audit_logs", force: :cascade do |t|
    t.string "auditable_type", null: false
    t.bigint "auditable_id", null: false
    t.string "action"
    t.bigint "changed_by_id"
    t.json "previous_data"
    t.json "new_data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["auditable_type", "auditable_id"], name: "index_audit_logs_on_auditable"
    t.index ["changed_by_id"], name: "index_audit_logs_on_changed_by_id"
  end

  create_table "expenses", force: :cascade do |t|
    t.bigint "team_id", null: false
    t.bigint "user_id", null: false
    t.decimal "amount"
    t.string "description"
    t.string "category"
    t.date "spent_on"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_expenses_on_deleted_at"
    t.index ["team_id"], name: "index_expenses_on_team_id"
    t.index ["user_id"], name: "index_expenses_on_user_id"
  end

  create_table "invitations", force: :cascade do |t|
    t.string "email", null: false
    t.bigint "team_id", null: false
    t.bigint "invited_by_id", null: false
    t.string "token", null: false
    t.datetime "accepted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email", "team_id"], name: "index_invitations_on_email_and_team_id", unique: true
    t.index ["email"], name: "index_invitations_on_email"
    t.index ["invited_by_id"], name: "index_invitations_on_invited_by_id"
    t.index ["team_id"], name: "index_invitations_on_team_id"
    t.index ["token"], name: "index_invitations_on_token", unique: true
  end

  create_table "jwt_denylists", force: :cascade do |t|
    t.string "jti"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "exp"
    t.index ["jti"], name: "index_jwt_denylists_on_jti"
  end

  create_table "team_memberships", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "team_id", null: false
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_team_memberships_on_team_id"
    t.index ["user_id", "team_id"], name: "index_team_memberships_on_user_id_and_team_id", unique: true
    t.index ["user_id"], name: "index_team_memberships_on_user_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "jti", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["jti"], name: "index_users_on_jti", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "audit_logs", "users", column: "changed_by_id"
  add_foreign_key "expenses", "teams"
  add_foreign_key "expenses", "users"
  add_foreign_key "invitations", "teams"
  add_foreign_key "invitations", "users", column: "invited_by_id"
  add_foreign_key "team_memberships", "teams"
  add_foreign_key "team_memberships", "users"
end
