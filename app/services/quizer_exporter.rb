require 'csv'

class QuizerExporter
  def initialize(quiz)
    @quiz = quiz
  end

  def questions_csv
    query = Quizer::Alternative.
      where(question_id: @quiz.questions.select(:id)).
      includes(:question).
      order(:question_id)

    CSV.generate(headers: true) do |csv|
      csv << %w{QuestionID Question QuestionType Position AlternativeID Alternative Correct CreatedAt UpdatedAt}

      query.each do |alternative|
        csv << [
          alternative.question_id,
          alternative.question.description,
          alternative.question.question_type,
          alternative.question.position,
          alternative.id,
          alternative.description,
          alternative.correct,
          alternative.created_at,
          alternative.updated_at
        ]
      end
    end
  end

  def answers_csv
    query = Quizer::AnswerAlternative.
      includes(answer: :quiz).
      joins(:answer).
      where(answer: { quiz_id: @quiz.id })

    CSV.generate(headers: true) do |csv|
      csv << %w{QuizId QuestionID UserHex AlternativeID Descriptive CreatedAt}

      query.each do |aa|
        csv << [
          aa.answer.question.quiz_id,
          aa.answer.question_id,
          aa.answer.session_hex,
          aa.alternative_id,
          aa.answer.descriptive,
          aa.created_at
        ]
      end
    end
  end
end
