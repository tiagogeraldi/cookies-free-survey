class Quizer::QuestionsController < Quizer::BaseController
  before_action :set_quiz_by_owner_secret
  before_action :set_question, only: %i[ edit update destroy move_up move_down move_top move_bottom ]

  layout 'quiz'

  # GET /quizer/questions
  def index
    @questions = @quiz.questions.order(:position)
  end

  # GET /quizer/questions/new
  def new
    @question = @quiz.questions.new
  end

  # GET /quizer/questions/1/edit
  def edit
  end

  # POST /quizer/questions
  def create
    @question = @quiz.questions.new(question_params)
    @question.position = @quiz.questions.maximum(:position).to_i + 1

    if @question.save
      if @question.open_ended?
        redirect_to quizer_quiz_questions_url(@quiz), notice: "Question was successfully created."
      else
        redirect_to quizer_quiz_question_alternatives_url(@quiz, @question)
      end
    else
      flash.now[:error] = @question.errors.full_messages.join('. ')
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /quizer/questions/1
  def update
    if @question.update(question_params)
      if params[:go_back]
        redirect_to params[:go_back]
      else
        redirect_to quizer_quiz_questions_url(@quiz), notice: "Question was successfully updated."
      end
    else
      flash.now[:error] = @question.errors.full_messages.join('. ')
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /quizer/questions/1
  def destroy
    @question.destroy

    redirect_to quizer_quiz_questions_url(@quiz), notice: "Question was successfully destroyed."
  end

  def move_up
    @question.switch_position!(@question.prev_question)
    redirect_to quizer_quiz_questions_url(@quiz)
  end

  def move_down
    @question.switch_position!(@question.next_question)
    redirect_to quizer_quiz_questions_url(@quiz)
  end

  def move_top
    @question.move_top!
    redirect_to quizer_quiz_questions_url(@quiz)
  end

  def move_bottom
    @question.move_bottom!
    redirect_to quizer_quiz_questions_url(@quiz)
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = @quiz.questions.find_by(id: params[:id])
    end

    # Only allow a list of trusted parameters through.
    def question_params
      params.require(:quizer_question).permit(:quiz_id, :question_type, :description)
    end
end
