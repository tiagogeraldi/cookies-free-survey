class Quizer::Answer < ApplicationRecord
  belongs_to :quiz
  belongs_to :question
  belongs_to :alternative, required: false

  has_many :answer_alternatives, class_name: 'Quizer::AnswerAlternative', dependent: :destroy
  has_many :alternatives, through: :answer_alternatives, class_name: 'Quizer::Alternative'

  validates :session_hex, :quiz, :question, presence: true

  # TODO
  # validate at least one alternative
end
