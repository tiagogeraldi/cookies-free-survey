class Quizer::Question < ApplicationRecord
  belongs_to :quiz, class_name: 'Quizer::Quiz'

  has_many :alternatives, class_name: 'Quizer::Alternative',
           dependent: :destroy

    has_many :answers, dependent: :destroy,
           class_name: 'Quizer::Answer',
           dependent: :destroy

  validates :description, presence: true

  enum :question_type, %i(alternatives descriptive)
end
