class Quizer::ExportsController < Quizer::BaseController
  before_action :set_quiz_by_owner_secret

  def index
  end

  def show
    response.headers['Content-Type'] = 'text/csv'

    if params[:id] == 'questions'
      send_data QuizerExporter.new(@quiz).questions_csv, filename: "questions.csv"
    elsif params[:id] == 'answers'
      send_data QuizerExporter.new(@quiz).answers_csv, filename: "answers.csv"
    end
  end
end
