class Quizer::QuizzesController < ApplicationController
  before_action :set_quizer_quiz, only: %i[ show edit update destroy ]

  # GET /quizer/quizzes or /quizer/quizzes.json
  def index
    @quizer_quizzes = Quizer::Quiz.all
  end

  # GET /quizer/quizzes/1 or /quizer/quizzes/1.json
  def show
  end

  # GET /quizer/quizzes/new
  def new
    @quizer_quiz = Quizer::Quiz.new
  end

  # GET /quizer/quizzes/1/edit
  def edit
  end

  # POST /quizer/quizzes or /quizer/quizzes.json
  def create
    @quizer_quiz = Quizer::Quiz.new(quizer_quiz_params)

    respond_to do |format|
      if @quizer_quiz.save
        format.html { redirect_to quizer_quiz_url(@quizer_quiz), notice: "Quiz was successfully created." }
        format.json { render :show, status: :created, location: @quizer_quiz }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @quizer_quiz.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /quizer/quizzes/1 or /quizer/quizzes/1.json
  def update
    respond_to do |format|
      if @quizer_quiz.update(quizer_quiz_params)
        format.html { redirect_to quizer_quiz_url(@quizer_quiz), notice: "Quiz was successfully updated." }
        format.json { render :show, status: :ok, location: @quizer_quiz }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @quizer_quiz.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quizer/quizzes/1 or /quizer/quizzes/1.json
  def destroy
    @quizer_quiz.destroy

    respond_to do |format|
      format.html { redirect_to quizer_quizzes_url, notice: "Quiz was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quizer_quiz
      @quizer_quiz = Quizer::Quiz.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def quizer_quiz_params
      params.require(:quizer_quiz).permit(:description, :public_results)
    end
end
