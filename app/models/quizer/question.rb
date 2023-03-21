class Quizer::Question < ApplicationRecord
  belongs_to :quiz, class_name: 'Quizer::Quiz'

  has_many :alternatives, class_name: 'Quizer::Alternative',
           dependent: :destroy

  has_many :answers, dependent: :destroy,
           class_name: 'Quizer::Answer',
           dependent: :destroy

  validates :description, :position, presence: true

  enum :question_type, %i(select_one select_one_or_more descriptive)

  DESCRIPTION_SURVEY_EXAMPLE = "Which of the following best describes your reason for using [product/service/company]?".freeze

  DESCRIPTION_QUIZ_EXAMPLE = "What is the capital city of Canada?".freeze

  QUESTION_TYPE_NAMES = {
    'select_one' => 'Select only one alternative',
    'select_one_or_more' => 'Select one or more alternatives',
    'descriptive' => 'Free descriptive text, no alternatives'
  }.freeze

  def self.question_types_for_select
    question_types.map do |key, value|
      [QUESTION_TYPE_NAMES[key], key]
    end
  end

  def prev_question
    quiz.questions.order(:position).where('position < ?', position).last
  end

  def next_question
    quiz.questions.order(:position).where('position > ?', position).first
  end

  def answers_count
    @answers_count ||= answers.count
  end

  def prev_question
    quiz.questions.order(:position).where('position < ?', position).last
  end

  def next_question
    quiz.questions.order(:position).where('position > ?', position).first
  end

  def switch_position!(other_question)
    transaction do
      new_position = other_question.position
      other_question.update! position: position
      update! position: new_position
    end
  end

  def move_top!
    transaction do
      update! position: 0
      update_all_below!
    end
  end

  def move_bottom!
    transaction do
      update! position: quiz.questions.count - 1
      update_all_above!
    end
  end

  private

  def all_except_self
    quiz.questions.where('id != ?', id).order(:position)
  end

  def update_all_below!
    all_except_self.each.with_index do |q, i|
      q.update! position: i + 1
    end
  end

  def update_all_above!
    all_except_self.each.with_index do |q, i|
      q.update! position: i
    end
  end
end
