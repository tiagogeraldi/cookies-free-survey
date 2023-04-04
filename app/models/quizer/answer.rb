class Quizer::Answer < ApplicationRecord
  belongs_to :quiz, counter_cache: true
  belongs_to :question

  has_many :answer_alternatives, class_name: 'Quizer::AnswerAlternative', dependent: :destroy
  has_many :alternatives, through: :answer_alternatives, class_name: 'Quizer::Alternative'

  validates :session_hex, :quiz, :question, presence: true
  validates :descriptive, presence: true, if: :open_ended?

  validate :at_least_one_alternative

  scope :count_by_session, -> {
    count('DISTINCT session_hex')
  }

  private

  def open_ended?
    question&.open_ended?
  end

  def at_least_one_alternative
    if question && alternatives.blank?
      if question.select_one?
        errors.add :base, 'Select one alternative'
      elsif question.select_one_or_more?
        errors.add :base, 'Select one or more alternatives'
      end
    end
  end
end
