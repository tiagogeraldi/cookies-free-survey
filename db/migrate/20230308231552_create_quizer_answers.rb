class CreateQuizerAnswers < ActiveRecord::Migration[7.0]
  def change
    create_table :quizer_answers do |t|
      t.string :session_hex
      t.uuid :quiz_id, null: false
      t.uuid :question_id, null: false
      t.uuid :alternative_id
      t.text :descriptive

      t.timestamps
    end

    add_foreign_key :quizer_answers, :quizer_quizzes, column: :quiz_id
    add_foreign_key :quizer_answers, :quizer_questions, column: :question_id
    add_foreign_key :quizer_answers, :quizer_alternatives, column: :alternative_id
    add_index :quizer_answers, :quiz_id
  end
end
