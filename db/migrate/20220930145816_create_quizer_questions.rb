class CreateQuizerQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :quizer_questions, id: :uuid do |t|
      t.references :quizer_quiz, null: false, foreign_key: true, index: true, type: :uuid
      t.integer :question_type
      t.text :description

      t.timestamps
    end
  end
end
