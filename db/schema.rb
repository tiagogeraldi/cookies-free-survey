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

ActiveRecord::Schema[7.0].define(version: 2022_10_18_001552) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "quizer_alternatives", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "question_id"
    t.text "description"
    t.boolean "correct", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_quizer_alternatives_on_question_id"
  end

  create_table "quizer_questions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "quiz_id"
    t.integer "question_type"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["quiz_id"], name: "index_quizer_questions_on_quiz_id"
  end

  create_table "quizer_quizzes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "description"
    t.string "owner_secret", limit: 20
    t.string "audience_secret", limit: 20
    t.boolean "public_results"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["audience_secret"], name: "index_quizer_quizzes_on_audience_secret", unique: true
    t.index ["owner_secret"], name: "index_quizer_quizzes_on_owner_secret", unique: true
  end

  add_foreign_key "quizer_alternatives", "quizer_questions", column: "question_id"
  add_foreign_key "quizer_questions", "quizer_quizzes", column: "quiz_id"
end
