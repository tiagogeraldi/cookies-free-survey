class Quizer::PaymentsController < Quizer::BaseController
  before_action :set_quiz_by_owner_secret

  layout 'quiz'

  def index
  end

  def create
    binding.break
  end
end
