class Quizer::Alternative < ApplicationRecord
  belongs_to :question, class_name: 'Quizer::Question', foreign_key: :quizer_question_id

  validates :description, presence: true
end
