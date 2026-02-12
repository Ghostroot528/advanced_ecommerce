class PaymentsController < ApplicationController
  def verify
    order = Order.find_by(razorpay_order_id: params[:razorpay_order_id])

    order.update!(
      payment_id: params[:razorpay_payment_id] || "TEST_PAYMENT",
      payment_status: "paid"
    )

    render json: { status: "success" }
  end
end
