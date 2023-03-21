FREE_PERIOD_DAYS = 14.freeze
PAID_PERIOD_DAYS = 180.freeze

class Quizer::Quiz < ApplicationRecord
  has_many :questions, dependent: :destroy,
           class_name: 'Quizer::Question'

  has_many :answers, dependent: :destroy,
           class_name: 'Quizer::Answer'

  validates :description, presence: true

  DESCRIPTION_SURVEY_EXAMPLE = %q("Start the Survey and Help Us Improve!"

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
    self.owner_secret = SecureRandom.hex(10)
    self.audience_secret = SecureRandom.hex(10)
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
end
