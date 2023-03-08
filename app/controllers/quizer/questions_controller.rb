class Quizer::QuestionsController < ApplicationController
  before_action :set_quiz
  before_action :set_quizer_question, only: %i[ edit update destroy ]

  # GET /quizer/questions
  def index
    @questions = @quiz.questions
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
    @question = @quiz.questions.new(quizer_question_params)
    if @question.save
      redirect_to quizer_quiz_questions_url(@quiz), notice: "Question was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /quizer/questions/1
  def update
    if @question.update(quizer_question_params)
      redirect_to quizer_quiz_questions_url(@quiz), notice: "Question was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /quizer/questions/1
  def destroy
    @question.destroy

    redirect_to quizer_quiz_questions_url(@quiz), notice: "Question was successfully destroyed."
  end

  private
    def set_quiz
      @quiz = Quizer::Quiz.find_by!(owner_secret: params[:quiz_owner_secret])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_quizer_question
      @question = @quiz.questions.find_by(id: params[:id])
    end

    # Only allow a list of trusted parameters through.
    def quizer_question_params
      params.require(:quizer_question).permit(:quiz_id, :question_type, :description)
    end
end
