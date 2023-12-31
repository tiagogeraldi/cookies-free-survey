class Quizer::QuizzesController < Quizer::BaseController
  before_action :set_quiz_by_owner_secret, only: %i(show results edit destroy update clone toggle_active)

  layout :resolve_layout

  # GET /quizer/quizzes
  def index
  end

  def help
  end

  # GET /quizer/quizzes/1
  def show
    @last_answer = @quiz.answers.last
  end

  # GET /quizer/quizzes/new
  def new
    description = if params[:quiz_type] == 'quiz'
      Quizer::Quiz::DESCRIPTION_QUIZ_EXAMPLE
    else
      Quizer::Quiz::DESCRIPTION_SURVEY_EXAMPLE
    end

    @quiz = Quizer::Quiz.new(
      quiz_type: params[:quiz_type],
      description: description
    )
    @quiz.generate_secrets
    @quiz.save!

    redirect_to @quiz
  end

  # GET /quizer/quizzes/1/edit
  def edit
  end

  # PATCH/PUT /quizer/quizzes/1
  def update
    if @quiz.update(quiz_params)
      redirect_to quizer_quiz_url(@quiz)
    else
      flash[:error] = @quiz.errors.full_messages.join('. ')
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /quizer/quizzes/1
  def destroy
    @quiz.destroy

    redirect_to quizer_quizzes_url
  end

  def toggle_active
    @quiz.update active: !@quiz.active

    respond_to do |format|
      format.turbo_stream {
        render turbo_stream: turbo_stream.replace("#{@quiz.id}-active", partial: 'active')
      }
      format.html { redirect_to @quiz }
    end
  end

  def clone
    cloned = @quiz.dup
    cloned.generate_secrets
    cloned.save!

    @quiz.questions.includes(:alternatives).find_each do |question|
      cloned_question = question.dup
      cloned_question.quiz = cloned
      cloned_question.save!

      question.alternatives.find_each do |alternative|
        cloned_question.alternatives << alternative.dup
      end
    end

    redirect_to cloned
  end

  private

  def resolve_layout
    case action_name
    when 'index'
      'audience'
    else
      'quiz'
    end
  end

  # Only allow a list of trusted parameters through.
  def quiz_params
    params.require(:quizer_quiz).permit(:description, :public_results, :quiz_type)
  end
end
