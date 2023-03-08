class Quizer::BaseController < ApplicationController

  protected

  def set_quiz_by_owner_secret
    @quiz = Quizer::Quiz.find_by!(owner_secret: params[:owner_secret] || params[:quiz_owner_secret])
  end

  def set_quiz_by_audience_secret
    @quiz = Quizer::Quiz.find_by!(audience_secret: params[:s])
  end
end
