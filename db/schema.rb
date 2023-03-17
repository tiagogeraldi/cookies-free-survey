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

ActiveRecord::Schema[7.0].define(version: 2023_03_10_214434) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "quizer_alternatives", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "question_id", null: false
    t.text "description"
    t.boolean "correct", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_quizer_alternatives_on_question_id"
  end

  create_table "quizer_answer_alternatives", force: :cascade do |t|
    t.uuid "answer_id", null: false
    t.uuid "alternative_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "quizer_answers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "session_hex"
    t.uuid "quiz_id", null: false
    t.uuid "question_id", null: false
    t.text "descriptive"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["quiz_id"], name: "index_quizer_answers_on_quiz_id"
  end

  create_table "quizer_questions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "quiz_id", null: false
    t.integer "question_type", null: false
    t.text "description", null: false
    t.integer "position"
    t.integer "alternatives_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["quiz_id"], name: "index_quizer_questions_on_quiz_id"
  end

  create_table "quizer_quizzes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "description"
    t.string "owner_secret", limit: 20, null: false
    t.string "audience_secret", limit: 20, null: false
    t.boolean "active", default: false
    t.boolean "paid", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["audience_secret"], name: "index_quizer_quizzes_on_audience_secret", unique: true
    t.index ["owner_secret"], name: "index_quizer_quizzes_on_owner_secret", unique: true
  end

  add_foreign_key "quizer_alternatives", "quizer_questions", column: "question_id"
  add_foreign_key "quizer_answer_alternatives", "quizer_alternatives", column: "alternative_id"
  add_foreign_key "quizer_answer_alternatives", "quizer_answers", column: "answer_id"
  add_foreign_key "quizer_answers", "quizer_questions", column: "question_id"
  add_foreign_key "quizer_answers", "quizer_quizzes", column: "quiz_id"
  add_foreign_key "quizer_questions", "quizer_quizzes", column: "quiz_id"
end
