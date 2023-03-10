class Quizer::Question < ApplicationRecord
  belongs_to :quiz, class_name: 'Quizer::Quiz'

  has_many :alternatives, class_name: 'Quizer::Alternative',
           dependent: :destroy

  has_many :answers, dependent: :destroy,
           class_name: 'Quizer::Answer',
           dependent: :destroy

  validates :description, :position, presence: true

  enum :question_type, %i(select_one select_one_or_more descriptive)
end
