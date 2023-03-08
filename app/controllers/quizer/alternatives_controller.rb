class Quizer::AlternativesController < ApplicationController
  before_action :set_quiz, :set_question
  before_action :set_quizer_alternative, only: %i[ edit update destroy ]

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
    @alternative = @question.alternatives.new(quizer_alternative_params)

    if @alternative.save
      redirect_to quizer_quiz_question_alternatives_url(@quiz, @question), notice: "Alternative was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /quizer/alternatives/1
  def update
    if @alternative.update(quizer_alternative_params)
      redirect_to quizer_quiz_question_alternatives_url(@quiz, @question), notice: "Alternative was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /quizer/alternatives/1
  def destroy
    @alternative.destroy

    redirect_to quizer_quiz_question_url(@quiz, @question), notice: "Alternative was successfully destroyed."
  end

  private
    def set_quiz
      @quiz = Quizer::Quiz.find_by!(owner_secret: params[:quiz_owner_secret])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = @quiz.questions.find_by(id: params[:question_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_quizer_alternative
      @alternative = @question.alternatives.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def quizer_alternative_params
      params.require(:quizer_alternative).permit(:quizer_question_id, :description, :correct)
    end
end
