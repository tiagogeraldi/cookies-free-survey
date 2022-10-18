class Quizer::Alternative < ApplicationRecord
  belongs_to :question, class_name: 'Quizer::Question'

  validates :description, presence: true
end
