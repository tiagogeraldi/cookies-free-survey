class ApplicationController < ActionController::Base
  add_flash_types :notice, :error

  after_action :skip_session
  skip_before_action :verify_authenticity_token

  private

  def skip_session
    request.session_options[:skip] = true
  end
end
