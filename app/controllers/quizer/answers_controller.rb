class Quizer::AnswersController < Quizer::BaseController
  before_action :set_quiz_by_audience_secret

  def index
    @session_hex = SecureRandom.hex(10)
  end

  def create
  end

  # When navigate back to previous question and save again
  def update
  end

  private

    # Only allow a list of trusted parameters through.
    def answer_params
      params.require(:quizer_answer).permit(:question_id, :session_hex, :alternative_id, :descriptive)
    end
end
