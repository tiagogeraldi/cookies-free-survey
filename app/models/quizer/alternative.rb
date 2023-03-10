class Quizer::Alternative < ApplicationRecord
  belongs_to :question, class_name: 'Quizer::Question'

  has_many :answer_alternatives, class_name: 'Quizer::AnswerAlternative', dependent: :restrict_with_error
  has_many :answers, through: :answer_alternatives, class_name: 'Quizer::Answer'

  validates :description, presence: true
end
