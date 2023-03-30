class Contact < ApplicationRecord
  validates :email, :message, presence: true
end
