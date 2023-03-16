class Quizer::Question < ApplicationRecord
  belongs_to :quiz, class_name: 'Quizer::Quiz'

  has_many :alternatives, class_name: 'Quizer::Alternative',
           dependent: :destroy

  has_many :answers, dependent: :destroy,
           class_name: 'Quizer::Answer',
           dependent: :destroy

  validates :description, :position, presence: true

  enum :question_type, %i(select_one select_one_or_more descriptive)

  def prev_question
    quiz.questions.order(:position).where('position < ?', position).last
  end

  def next_question
    quiz.questions.order(:position).where('position > ?', position).first
  end

  def answers_count
    @answers_count ||= answers.count
  end

  # def first?
  #   quiz.questions.order(:position).first == self
  # end

  # def last?
  #   quiz.questions.order(:position).last == self
  # end

  def prev_question
    quiz.questions.order(:position).where('position < ?', position).last
  end

  def next_question
    quiz.questions.order(:position).where('position > ?', position).first
  end

  def move_up!
    transaction do
      prev_question.update! position: position
      update! position: position - 1
    end
  end

  def move_down!
    transaction do
      next_question.update! position: position
      update! position: position + 1
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
