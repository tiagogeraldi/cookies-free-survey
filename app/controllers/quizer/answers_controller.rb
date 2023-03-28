class Quizer::AnswersController < Quizer::BaseController
  before_action :set_quiz_by_audience_secret
  before_action :set_question, :set_session_hex, except: %i(index done)

  layout 'audience'

  def index
    @session_hex = SecureRandom.hex(10)
    @first_question = @quiz.questions.order(:position).first
  end

  def new
    @answer = @question.answers.find_or_initialize_by(session_hex: @session_hex)

    if !@question.open_ended? && @question.alternatives.blank?
      flash.now[:error] = "This question has no alternatives"
    end
  end

  def upsert
    @answer = @question.answers.find_or_initialize_by(session_hex: @session_hex)
    @answer.quiz = @quiz
    @answer.assign_attributes(answer_params)

    if @answer.save
      redirect_to_next_question
    else
      flash.now[:error] = @answer.errors.full_messages.join('. ')
      render action: :new, status: :unprocessable_entity
    end
  end

  def done
    if @quiz.quiz?
      @answers_count = @quiz.questions.count
      @correct_answers_count = @quiz.correct_answers_count(params[:session_hex])
    end
  end

  private

  def redirect_to_next_question
    session_hex = answer_params[:session_hex]

    if @question.next_question
      redirect_to new_quizer_answer_path(
        s: params[:s],
        session_hex: session_hex,
        question_id: @question.next_question.id
      )
    else
      redirect_to done_quizer_answers_path(s: params[:s], session_hex: session_hex)
    end
  end

  def set_question
    @question = Quizer::Question.find(params[:question_id])
  end

  def set_session_hex
    @session_hex = params[:session_hex] || answer_params[:session_hex]
  end

  # Only allow a list of trusted parameters through.
  def answer_params
    params.require(:quizer_answer).permit(
      :quiz_id, :session_hex, :descriptive,
      # checkboxes send IDs as array, radio single option as string
      :alternative_ids, alternative_ids: []
    )
  end
end
