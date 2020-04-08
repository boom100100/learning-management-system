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

ActiveRecord::Schema.define(version: 6) do

  create_table "admins", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.index ["username"], name: "index_admins_on_username", unique: true
  end

  create_table "courses", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "teacher_id"
    t.string "student_id"
  end

  create_table "lessons", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "content"
    t.string "transcript"
    t.string "video_url"
    t.string "dir_url"
    t.integer "course_id"
    t.integer "tag_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
  end

  create_table "teachers", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
  end

end
