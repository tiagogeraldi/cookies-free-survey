class Quizer::PaymentsController < Quizer::BaseController
  before_action :set_quiz_by_owner_secret

  layout 'quiz'

  def index
  end

  def create
    response = HTTParty.post(Rails.application.config.paypal_url + '/v2/checkout/orders',
      basic_auth: { username: ENV['PAYPAL_CLIENT_ID'], password: ENV['PAYPAL_SECRET'] },
      headers: { 'Content-Type' => 'application/json' },
      body: {
        "purchase_units": [
          {
            "amount": {
              "currency_code": "USD",
              "value": "5.00"
            },
            "reference_id": "#{@quiz.owner_secret}"
          }
        ],
        "intent": "CAPTURE"
      }.to_json
    )
    @quiz.update!(order_id: response["id"])

    render json: response
  end

  def approve
    response = HTTParty.post(Rails.application.config.paypal_url + "/v2/checkout/orders/#{@quiz.order_id}/capture",
      basic_auth: { username: ENV['PAYPAL_CLIENT_ID'], password: ENV['PAYPAL_SECRET'] },
      headers: { 'Content-Type' => 'application/json' }
    )
    @quiz.update!(paid: true)
    render json: response
  end
end
