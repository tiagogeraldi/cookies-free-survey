class CreateQuizerAlternatives < ActiveRecord::Migration[7.0]
  def change
    create_table :quizer_alternatives, id: :uuid do |t|
      t.uuid :question_id
      t.text :description
      t.boolean :correct, default: false

      t.timestamps
    end

    add_foreign_key :quizer_alternatives, :quizer_questions, column: :question_id
    add_index :quizer_alternatives, :question_id
  end
end
