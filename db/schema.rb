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

ActiveRecord::Schema[8.0].define(version: 2026_01_06_175415) do
  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "announcements", force: :cascade do |t|
    t.integer "klass_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.index ["klass_id"], name: "index_announcements_on_klass_id"
    t.index ["user_id"], name: "index_announcements_on_user_id"
  end

  create_table "assignments", force: :cascade do |t|
    t.integer "klass_id", null: false
    t.integer "user_id", null: false
    t.string "title", null: false
    t.datetime "deadline"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "max_score", default: 100, null: false
    t.decimal "weight", precision: 5, scale: 2, default: "1.0", null: false
    t.integer "max_attempts"
    t.boolean "can_submit_after_deadline"
    t.json "accept_content_types"
    t.index ["klass_id"], name: "index_assignments_on_klass_id"
    t.index ["user_id"], name: "index_assignments_on_user_id"
  end

  create_table "contents", force: :cascade do |t|
    t.integer "klass_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "module_name"
    t.string "title"
    t.text "description"
    t.index ["klass_id"], name: "index_contents_on_klass_id"
    t.index ["user_id"], name: "index_contents_on_user_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "number"
    t.index ["name"], name: "index_courses_on_name", unique: true
  end

  create_table "klasses", force: :cascade do |t|
    t.string "code", null: false
    t.integer "course_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code", "course_id"], name: "index_klasses_on_code_and_course_id", unique: true
    t.index ["course_id"], name: "index_klasses_on_course_id"
  end

  create_table "modules", force: :cascade do |t|
    t.string "name"
    t.integer "klass_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["klass_id"], name: "index_modules_on_klass_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "ip_address"
    t.string "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "settings", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "organization_name"
  end

  create_table "students", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "klass_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["klass_id", "user_id"], name: "index_students_on_klass_id_and_user_id", unique: true
    t.index ["klass_id"], name: "index_students_on_klass_id"
    t.index ["user_id"], name: "index_students_on_user_id"
  end

  create_table "submissions", force: :cascade do |t|
    t.integer "assignment_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "score", precision: 6, scale: 2
    t.integer "attempts", default: 1
    t.boolean "is_graded"
    t.integer "teacher_id"
    t.index ["assignment_id"], name: "index_submissions_on_assignment_id"
    t.index ["teacher_id"], name: "index_submissions_on_teacher_id"
    t.index ["user_id"], name: "index_submissions_on_user_id"
  end

  create_table "teachers", force: :cascade do |t|
    t.integer "klass_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["klass_id", "user_id"], name: "index_teachers_on_klass_id_and_user_id", unique: true
    t.index ["klass_id"], name: "index_teachers_on_klass_id"
    t.index ["user_id"], name: "index_teachers_on_user_id"
  end

  create_table "timings", force: :cascade do |t|
    t.datetime "start"
    t.datetime "end"
    t.integer "klass_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["klass_id"], name: "index_timings_on_klass_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email_address", null: false
    t.string "password_digest", null: false
    t.string "role", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", null: false
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "announcements", "klasses"
  add_foreign_key "announcements", "users"
  add_foreign_key "assignments", "klasses"
  add_foreign_key "assignments", "users"
  add_foreign_key "contents", "klasses"
  add_foreign_key "contents", "users"
  add_foreign_key "klasses", "courses"
  add_foreign_key "modules", "klasses"
  add_foreign_key "sessions", "users"
  add_foreign_key "students", "klasses"
  add_foreign_key "students", "users"
  add_foreign_key "submissions", "assignments"
  add_foreign_key "submissions", "teachers"
  add_foreign_key "submissions", "users"
  add_foreign_key "teachers", "klasses"
  add_foreign_key "teachers", "users"
  add_foreign_key "timings", "klasses"
end
