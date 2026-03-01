class PaymentsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def verify
    order = Order.find_by(razorpay_order_id: params[:razorpay_order_id])

    order.update!(
      payment_id: params[:razorpay_payment_id],
      payment_status: "paid"
    )
    OrderMailer.order_confirmation(order).deliver_later
    OrderMailer.admin_notification(order).deliver_later
    session[:cart] = {}

    render json: { status: "success" }
  end
end
