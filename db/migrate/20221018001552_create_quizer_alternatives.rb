class CreateQuizerAlternatives < ActiveRecord::Migration[7.0]
  def change
    create_table :quizer_alternatives, id: :uuid do |t|
      t.references :quizer_question, null: false, foreign_key: true, index: true, type: :uuid
      t.text :description
      t.boolean :correct, default: false

      t.timestamps
    end
  end
end
