class Quizer::AnswerAlternative < ApplicationRecord
  belongs_to :answer
  belongs_to :alternative
end
