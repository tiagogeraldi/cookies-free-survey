class Quizer::Quiz < ApplicationRecord
  has_many :questions, dependent: :destroy,
           class_name: 'Quizer::Question',
           dependent: :destroy

  has_many :answers, dependent: :destroy,
           class_name: 'Quizer::Answer',
           dependent: :destroy

  validates :description, presence: true

  def generate_secrets
    self.owner_secret = SecureRandom.hex(10)
    self.audience_secret = SecureRandom.hex(10)
  end

  def to_param
    owner_secret
  end
end
