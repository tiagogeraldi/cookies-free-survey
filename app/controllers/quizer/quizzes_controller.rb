class Quizer::QuizzesController < ApplicationController
  before_action :set_quiz_by_owner_secret, only: %i(show edit destroy update)

  # GET /quizer/quizzes
  def index
  end

  # GET /quizer/quizzes/1
  def show
  end

  def results
    @quizer_quiz = Quizer::Quiz.find_by!(audience_secret: params[:s])
  end

  # GET /quizer/quizzes/new
  def new
    @quizer_quiz = Quizer::Quiz.new
  end

  # GET /quizer/quizzes/1/edit
  def edit
  end

  # POST /quizer/quizzes
  def create
    @quizer_quiz = Quizer::Quiz.new(quizer_quiz_params)
    @quizer_quiz.generate_secrets

    if @quizer_quiz.save
      redirect_to quizer_quiz_url(@quizer_quiz), notice: "Quiz was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /quizer/quizzes/1
  def update
    if @quizer_quiz.update(quizer_quiz_params)
      redirect_to quizer_quiz_url(@quizer_quiz), notice: "Quiz was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /quizer/quizzes/1
  def destroy
    @quizer_quiz.destroy

    redirect_to quizer_quizzes_url, notice: "Quiz was successfully destroyed."
  end

  private

  def set_quiz_by_owner_secret
    @quizer_quiz = Quizer::Quiz.find_by!(owner_secret: params[:owner_secret])
  end

  # Only allow a list of trusted parameters through.
  def quizer_quiz_params
    params.require(:quizer_quiz).permit(:description, :public_results)
  end
end
