class Quizer::AlternativesController < Quizer::BaseController
  before_action :set_quiz_by_owner_secret, :set_question
  before_action :set_quizer_alternative, only: %i[ edit update destroy ]

  layout 'quiz'

  # GET /quizer/alternatives
  def index
    @alternatives = @question.alternatives
  end

  # GET /quizer/alternatives/new
  def new
    @alternative = @question.alternatives.new
  end

  # GET /quizer/alternatives/1/edit
  def edit
  end

  # POST /quizer/alternatives or /quizer/alternatives.json
  def create
    @alternative = @question.alternatives.new(alternative_params)

    if @alternative.save
      redirect_to quizer_quiz_question_alternatives_url(@quiz, @question)
    else
      flash.now[:error] = @alternative.errors.full_messages.join('. ')
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /quizer/alternatives/1
  def update
    if @alternative.update(alternative_params)
      redirect_to quizer_quiz_question_alternatives_url(@quiz, @question)
    else
      flash.now[:error] = @alternative.errors.full_messages.join('. ')
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /quizer/alternatives/1
  def destroy
    @alternative.destroy

    redirect_to quizer_quiz_question_url(@quiz, @question)
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = @quiz.questions.find_by(id: params[:question_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_quizer_alternative
      @alternative = @question.alternatives.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def alternative_params
      params.require(:quizer_alternative).permit(:question_id, :description, :correct)
    end
end
