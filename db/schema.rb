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

ActiveRecord::Schema[7.0].define(version: 2022_09_30_145816) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "quizer_questions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "quizer_quiz_id", null: false
    t.integer "question_type"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["quizer_quiz_id"], name: "index_quizer_questions_on_quizer_quiz_id"
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

  add_foreign_key "quizer_questions", "quizer_quizzes"
end
