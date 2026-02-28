class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = current_user.orders.order(created_at: :desc)
  end
  def new
    @cart = session[:cart] || {}
    @products = Product.where(id: @cart.keys)

    redirect_to root_path if @products.empty?
  end

  def create
    cart = session[:cart] || {}
    products = Product.where(id: cart.keys)

    total = products.sum { |p| p.price * cart[p.id.to_s].to_i }

    order = current_user.orders.create!(
      total: total,
      payment_status: "pending",
      status: "placed"
    )

    Razorpay.setup(
      Rails.application.credentials.dig(:razorpay, :key_id),
      Rails.application.credentials.dig(:razorpay, :key_secret)
    )

    razorpay_order = Razorpay::Order.create(
      amount: total * 100,
      currency: "INR",
      receipt: "order_#{order.id}"
    )

    order.update!(razorpay_order_id: razorpay_order.id)

    redirect_to order_path(order)
  end

  def show
    @order = current_user.orders.find(params[:id])
    @razorpay_key = Rails.application.credentials.dig(:razorpay, :key_id)
  end
end
