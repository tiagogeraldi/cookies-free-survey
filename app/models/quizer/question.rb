class Quizer::Question < ApplicationRecord
  belongs_to :quiz, class_name: 'Quizer::Quiz', foreign_key: :quizer_quiz_id
  has_many :alternatives, class_name: 'Quizer::Alternative',
           foreign_key: :quizer_question_id,
           dependent: :destroy

  validates :description, presence: true

  enum :question_type, %i(alternatives descriptive)
end
