class Quizer::Quiz < ApplicationRecord
  validates :description, presence: true

  def generate_secrets
    self.owner_secret = SecureRandom.hex(10)
    self.audience_secret = SecureRandom.hex(10)
  end

  def to_param
    owner_secret
  end
end
