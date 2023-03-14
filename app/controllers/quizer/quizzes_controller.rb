class Quizer::QuizzesController < Quizer::BaseController
  before_action :set_quiz_by_owner_secret, only: %i(show results edit destroy update)

  # GET /quizer/quizzes
  def index
  end

  # GET /quizer/quizzes/1
  def show
    if @quiz.answers.blank?
      flash.now[:error] = "Nobody has answered your survey so far"
    end
  end

  def results
    @answers = @quiz.answers.
      includes(:alternatives, :quiz, :question).
      order(created_at: :desc).
      paginate(page: params[:page], per_page: 30)
  end

  # GET /quizer/quizzes/new
  def new
    @quiz = Quizer::Quiz.new
  end

  # GET /quizer/quizzes/1/edit
  def edit
  end

  # POST /quizer/quizzes
  def create
    @quiz = Quizer::Quiz.new(quiz_params)
    @quiz.generate_secrets

    if @quiz.save
      redirect_to quizer_quiz_url(@quiz), notice: "Quiz was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /quizer/quizzes/1
  def update
    if @quiz.update(quiz_params)
      redirect_to quizer_quiz_url(@quiz), notice: "Quiz was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /quizer/quizzes/1
  def destroy
    @quiz.destroy

    redirect_to quizer_quizzes_url, notice: "Quiz was successfully destroyed."
  end

  private

  # Only allow a list of trusted parameters through.
  def quiz_params
    params.require(:quizer_quiz).permit(:description, :public_results)
  end
end
