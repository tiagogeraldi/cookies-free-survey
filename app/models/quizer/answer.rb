class Quizer::Answer < ApplicationRecord
  belongs_to :quiz
  belongs_to :question
  belongs_to :alternative, required: false

  has_many :answer_alternatives, class_name: 'Quizer::AnswerAlternative', dependent: :destroy
  has_many :alternatives, through: :answer_alternatives, class_name: 'Quizer::Alternative'

  validates :session_hex, :quiz, :question, presence: true
  validates :descriptive, presence: true, if: :descriptive?

  validate :at_least_one_alternative

  private

  def descriptive?
    question.descriptive?
  end

  def at_least_one_alternative
    if alternatives.blank?
      if question.select_one?
        errors.add :base, 'Select one alternative'
      elsif question.select_one_or_more?
        errors.add :base, 'Select one or more alternatives'
      end
    end
  end
end
