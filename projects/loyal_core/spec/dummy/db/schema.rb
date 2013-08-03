# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20130610095938) do

  create_table "kindeditor_assets", force: true do |t|
    t.string   "asset"
    t.string   "file_name"
    t.integer  "file_size"
    t.string   "file_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "loyal_core_like_tracks", force: true do |t|
    t.integer  "target_id"
    t.string   "target_type"
    t.integer  "created_by"
    t.string   "created_ip"
    t.integer  "position",    default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "loyal_core_like_tracks", ["created_by"], name: "index_loyal_core_like_tracks_on_created_by"
  add_index "loyal_core_like_tracks", ["target_id", "target_type"], name: "loyal_core_like_tracks_target"

  create_table "loyal_core_rating_tracks", force: true do |t|
    t.integer  "target_id"
    t.string   "target_type"
    t.integer  "created_by"
    t.string   "created_ip"
    t.integer  "score",       default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "loyal_core_rating_tracks", ["created_by"], name: "index_loyal_core_rating_tracks_on_created_by"
  add_index "loyal_core_rating_tracks", ["target_id", "target_type"], name: "loyal_core_rating_tracks_target"

  create_table "loyal_core_skin_dishes", force: true do |t|
    t.integer  "target_id"
    t.string   "target_type"
    t.integer  "recipe_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "loyal_core_skin_folders", force: true do |t|
    t.string   "name"
    t.string   "short_name"
    t.integer  "publish_status", default: 0, null: false
    t.integer  "created_by"
    t.string   "created_ip"
    t.string   "instroduction"
    t.text     "description"
    t.integer  "lang",           default: 0, null: false
    t.string   "uuid"
    t.string   "space"
    t.string   "permalink"
    t.string   "avatar"
    t.integer  "parent_id"
    t.integer  "left_id"
    t.integer  "right_id"
    t.integer  "depth"
    t.integer  "children_count", default: 0
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "loyal_core_skin_folders", ["left_id"], name: "index_loyal_core_skin_folders_on_left_id"
  add_index "loyal_core_skin_folders", ["parent_id"], name: "index_loyal_core_skin_folders_on_parent_id"
  add_index "loyal_core_skin_folders", ["right_id"], name: "index_loyal_core_skin_folders_on_right_id"
  add_index "loyal_core_skin_folders", ["space", "permalink"], name: "index_loyal_core_skin_folders_on_space_and_permalink"
  add_index "loyal_core_skin_folders", ["uuid"], name: "index_loyal_core_skin_folders_on_uuid"

  create_table "loyal_core_skin_recipes", force: true do |t|
    t.integer  "folder_id"
    t.string   "name"
    t.string   "short_name"
    t.string   "avatar"
    t.string   "stored_tags"
    t.string   "assets_path"
    t.text     "stylesheet_text"
    t.integer  "created_by"
    t.string   "created_ip"
    t.string   "instroduction"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "loyal_passport_assignments", force: true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.integer  "position",       default: 0, null: false
    t.integer  "publish_status", default: 0
    t.integer  "level",          default: 0, null: false
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "loyal_passport_assignments", ["role_id"], name: "index_loyal_passport_assignments_on_role_id"
  add_index "loyal_passport_assignments", ["user_id"], name: "index_loyal_passport_assignments_on_user_id"

  create_table "loyal_passport_homeworks", force: true do |t|
    t.string   "name"
    t.string   "job_name"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "loyal_passport_lockers", force: true do |t|
    t.integer  "target_id"
    t.integer  "owner_id"
    t.integer  "position",       default: 0, null: false
    t.integer  "publish_status", default: 0
    t.integer  "level",          default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "loyal_passport_roles", force: true do |t|
    t.string   "permalink",      default: "", null: false
    t.string   "name",           default: "", null: false
    t.string   "instroduction"
    t.text     "description"
    t.integer  "publish_status", default: 0,  null: false
    t.datetime "deleted_at"
    t.string   "avatar"
  end

  add_index "loyal_passport_roles", ["permalink"], name: "index_loyal_passport_roles_on_permalink"

  create_table "sessions", force: true do |t|
    t.string   "session_id", default: "", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at"

  create_table "users", force: true do |t|
    t.string   "true_name",                   default: "", null: false
    t.string   "nick_name",                   default: "", null: false
    t.string   "permalink",                   default: "", null: false
    t.string   "email",                       default: "", null: false
    t.string   "encrypted_password",          default: "", null: false
    t.string   "mobile_number",               default: "", null: false
    t.string   "mobile_confirmation_token"
    t.datetime "mobile_confirmed_at"
    t.datetime "mobile_confirmation_sent_at"
    t.string   "unconfirmed_mobile"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",               default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",             default: 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "authentication_token"
    t.string   "avatar"
    t.datetime "deleted_at"
    t.integer  "publish_status",              default: 0,  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", unique: true
  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email"
  add_index "users", ["mobile_confirmation_token"], name: "index_users_on_mobile_confirmation_token", unique: true
  add_index "users", ["mobile_number"], name: "index_users_on_mobile_number"
  add_index "users", ["nick_name"], name: "index_users_on_nick_name"
  add_index "users", ["permalink"], name: "index_users_on_permalink"
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["true_name"], name: "index_users_on_true_name"
  add_index "users", ["unconfirmed_email"], name: "index_users_on_unconfirmed_email"
  add_index "users", ["unconfirmed_mobile"], name: "index_users_on_unconfirmed_mobile"
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true

end
