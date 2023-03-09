class Quizer::AnswersController < Quizer::BaseController
  before_action :set_quiz_by_audience_secret

  def index
    @session_hex = SecureRandom.hex(10)

    if @quiz.questions.blank?
      flash.now[:error] = "This survey has no questions"
    end
  end

  def new
    @question = Quizer::Question.find(params[:question_id])
    @session_hex = params[:session_hex]
    @answer = Quizer::Answer.new

    if @question.alternatives.blank?
      flash.now[:error] = "This question has no alternatives"
    end
  end

  def create
    # add quiz as attribute
  end

  # When navigate back to previous question and save again
  def update
  end

  private

    # Only allow a list of trusted parameters through.
    def answer_params
      params.require(:quizer_answer).permit(:quiz_id, :question_id, :session_hex, :alternative_id, :descriptive)
    end
end
