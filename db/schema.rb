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

ActiveRecord::Schema.define(version: 20160519121059) do

  create_table "context_appointments", force: :cascade do |t|
    t.integer  "context_id"
    t.integer  "user_id"
    t.string   "role_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "context_appointments", ["context_id", "user_id", "role_name"], name: "index_context_appointments_context_user_role", unique: true
  add_index "context_appointments", ["context_id"], name: "index_context_appointments_on_context_id"
  add_index "context_appointments", ["user_id"], name: "index_context_appointments_on_user_id"

  create_table "contexts", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "slug"
    t.string   "type"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "sid"
  end

  add_index "contexts", ["sid"], name: "index_contexts_on_sid", unique: true
  add_index "contexts", ["slug"], name: "index_contexts_on_slug", unique: true
  add_index "contexts", ["user_id"], name: "index_contexts_on_user_id"

  create_table "submission_files", force: :cascade do |t|
    t.string   "sid"
    t.integer  "revision_id"
    t.string   "file_data"
    t.string   "file_type"
    t.string   "aasm_state"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "submission_files", ["revision_id", "file_type"], name: "index_submission_files_revision_type", unique: true
  add_index "submission_files", ["revision_id"], name: "index_submission_files_on_revision_id"

  create_table "submission_revision_decisions", force: :cascade do |t|
    t.string   "decision"
    t.text     "comment"
    t.integer  "revision_id"
    t.integer  "user_id"
    t.string   "aasm_state"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "submission_revision_decisions", ["revision_id"], name: "index_submission_revision_decisions_on_revision_id"
  add_index "submission_revision_decisions", ["user_id"], name: "index_submission_revision_decisions_on_user_id"

  create_table "submission_revision_reviews", force: :cascade do |t|
    t.string   "decision"
    t.text     "comment"
    t.integer  "revision_id"
    t.integer  "user_id"
    t.string   "aasm_state"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "submission_revision_reviews", ["revision_id", "user_id"], name: "index_submission_revision_reviews_revision_user", unique: true
  add_index "submission_revision_reviews", ["revision_id"], name: "index_submission_revision_reviews_on_revision_id"
  add_index "submission_revision_reviews", ["user_id"], name: "index_submission_revision_reviews_on_user_id"

  create_table "submission_revisions", force: :cascade do |t|
    t.string   "sid"
    t.integer  "submission_id"
    t.integer  "revision_n",    default: 0
    t.string   "aasm_state"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "submission_revisions", ["submission_id"], name: "index_submission_revisions_on_submission_id"

  create_table "submissions", force: :cascade do |t|
    t.string   "title"
    t.text     "abstract"
    t.string   "sid"
    t.integer  "user_id"
    t.integer  "context_id"
    t.integer  "revision_seq",               default: 0
    t.integer  "last_created_revision_id"
    t.integer  "last_submitted_revision_id"
    t.string   "aasm_state"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "submissions", ["context_id"], name: "index_submissions_on_context_id"
  add_index "submissions", ["user_id"], name: "index_submissions_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.integer  "userpin"
    t.string   "avatar"
    t.string   "sid"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "fname"
    t.string   "mname"
    t.string   "lname"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["sid"], name: "index_users_on_sid", unique: true
  add_index "users", ["userpin"], name: "index_users_on_userpin", unique: true

end
