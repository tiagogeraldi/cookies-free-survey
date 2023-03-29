class Quizer::Quiz < ApplicationRecord
  FREE_PERIOD_DAYS = 14.freeze
  PAID_PERIOD_DAYS = 180.freeze

  has_many :questions, dependent: :destroy,
           class_name: 'Quizer::Question'

  has_many :answers, dependent: :destroy,
           class_name: 'Quizer::Answer'

  validates :description, :quiz_type, presence: true

  enum :quiz_type, %i(quiz survey)

  DESCRIPTION_SURVEY_EXAMPLE = %q(Start the Survey and Help Us Improve!

By taking this brief survey, you can help us understand how we can better serve your needs. We value your feedback and will use it to improve our products and services. The survey will only take a few minutes of your time, and your responses will be kept completely confidential.

To get started, simply click the button below:
  ).freeze

  DESCRIPTION_QUIZ_EXAMPLE = %q("Get Ready to Test Your Knowledge!"

Our Ultimate Trivia Challenge is the perfect way to challenge yourself and have some fun.
With questions covering a wide range of topics, from history to pop culture,
you're sure to learn something new and maybe even surprise yourself.

To get started, simply click the button below:
  ).freeze

  def generate_secrets
    loop do
      self.owner_secret = SecureRandom.hex(6)
      break if Quizer::Quiz.where(owner_secret: self.owner_secret).blank?
    end
    loop do
      self.audience_secret = SecureRandom.hex(6)
     break if Quizer::Quiz.where(audience_secret: self.audience_secret).blank?
   end
  end

  def to_param
    owner_secret
  end

  def expiration_date
    if paid
      created_at + PAID_PERIOD_DAYS.days
    else
      created_at + FREE_PERIOD_DAYS.days
    end.to_date
  end

  # Valid only for Quiz types:
  #
  # For select_one question type,
  # just count whenever they answered a correct alternative.
  #
  # For select_one_or_more,
  # Consider correct when they answered at least one correct alternative,
  # but haven't selected any incorrect alternative
  def correct_answers_count(session_hex)
    scope = answers.
      preload(:alternatives, :question).
      joins(:alternatives, :question).
      where(session_hex: session_hex)

    correct_count = scope.
      where(
        quizer_questions: { question_type: 'select_one' },
        quizer_alternatives: { correct: true }
      ).count

    scope.where(quizer_questions: { question_type: 'select_one_or_more' }).each do |answer|
      correct_ids = answer.question.alternatives.select(&:correct).map(&:id)
      answered_ids = answer.alternatives.map(&:id)

      if (answered_ids - correct_ids).blank?
        correct_count += 1
      end
    end

    correct_count
  end
end
