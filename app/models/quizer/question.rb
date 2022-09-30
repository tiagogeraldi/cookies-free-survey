class Quizer::Question < ApplicationRecord
  belongs_to :quizer_quiz, class_name: 'Quizer::Quiz'

  validates :description, presence: true

  enum :question_type, %i(alternatives descriptive)
end
