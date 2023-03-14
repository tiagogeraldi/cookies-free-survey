class Quizer::ResultsController < Quizer::BaseController
  before_action :set_quiz_by_owner_secret

  def index
    @total_people = @quiz.answers.count_by_session
    @total_questions = @quiz.questions.count
  end

  def show
    @question = @quiz.questions.find(params[:id])
    @alternatives = @question.alternatives.includes(:answers)
  end

  def logs
    @answers = @quiz.answers.
      includes(:alternatives, :quiz, :question).
      order(created_at: :desc).
      paginate(page: params[:page], per_page: 30)
  end
end
