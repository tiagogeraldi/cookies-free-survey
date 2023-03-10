class CreateQuizerAnswerAlternatives < ActiveRecord::Migration[7.0]
  def change
    create_table :quizer_answer_alternatives do |t|
      t.uuid :answer_id, null: false
      t.uuid :alternative_id, null: false

      t.timestamps
    end

    add_foreign_key :quizer_answer_alternatives, :quizer_answers, column: :answer_id
    add_foreign_key :quizer_answer_alternatives, :quizer_alternatives, column: :alternative_id
  end
end
