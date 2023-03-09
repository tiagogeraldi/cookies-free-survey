class Quizer::Answer < ApplicationRecord
  belongs_to :quiz
  belongs_to :question
  belongs_to :alternative, required: false
end
