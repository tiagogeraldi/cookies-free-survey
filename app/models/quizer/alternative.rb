class Quizer::Alternative < ApplicationRecord
  belongs_to :question, counter_cache: true

  has_many :answer_alternatives, class_name: 'Quizer::AnswerAlternative', dependent: :restrict_with_error
  has_many :answers, through: :answer_alternatives, class_name: 'Quizer::Answer'

  validates :description, presence: true

  DESCRIPTION_SURVEY_EXAMPLE = "Quality of the product/service".freeze

  DESCRIPTION_QUIZ_EXAMPLE = "Toronto".freeze

  def answers_count
    @answers_count ||= answers.count
  end

  def percentage
    if answers_count > 0 && question.answers_count > 0
      answers_count.to_f * 100 / question.answers_count.to_f
    else
      0
    end
  end
end
