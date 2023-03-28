class CreateQuizerQuizzes < ActiveRecord::Migration[7.0]
  def change
    create_table :quizer_quizzes, id: :uuid do |t|
      t.text :description
      t.string :owner_secret, limit: 20, null: false
      t.string :audience_secret, limit: 20, null: false
      t.boolean :active, default: true
      t.boolean :paid, default: false
      t.integer :quiz_type

      t.timestamps
    end

    add_index :quizer_quizzes, :owner_secret, unique: true
    add_index :quizer_quizzes, :audience_secret, unique: true
  end
end
