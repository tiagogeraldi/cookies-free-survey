class Quizer::ResultsController < Quizer::BaseController
  before_action :set_quiz_by_owner_secret
  before_action :no_answer_warning, only: %i(index logs)

  layout 'quiz'

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

  def delete_all
    @quiz.answers.destroy_all

    redirect_to quizer_quiz_results_path(@quiz)
  end

  private

  def no_answer_warning
    if @quiz.answers.blank?
      flash[:error] = "Nobody has answered your survey so far"
    end
  end
end
