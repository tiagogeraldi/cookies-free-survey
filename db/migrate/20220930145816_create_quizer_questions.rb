class CreateQuizerQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :quizer_questions, id: :uuid do |t|
      t.uuid :quiz_id, null: false
      t.integer :question_type, null: false
      t.text :description, null: false

      t.timestamps
    end

    add_foreign_key :quizer_questions, :quizer_quizzes, column: :quiz_id
    add_index :quizer_questions, :quiz_id
  end
end
