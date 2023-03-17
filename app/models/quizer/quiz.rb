FREE_PERIOD_DAYS = 14.freeze
PAID_PERIOD_DAYS = 180.freeze

class Quizer::Quiz < ApplicationRecord
  has_many :questions, dependent: :destroy,
           class_name: 'Quizer::Question'

  has_many :answers, dependent: :destroy,
           class_name: 'Quizer::Answer'

  validates :description, presence: true

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
