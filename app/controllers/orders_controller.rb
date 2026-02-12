class OrdersController < ApplicationController
  before_action :authenticate_user!

  # Checkout page
  def new
    @cart = session[:cart] || {}
    product_ids = @cart.keys
    @products = Product.where(id: product_ids)
  end

  # Create Order
  def create
  cart = session[:cart] || {}

  products = Product.where(id: cart.keys)

  total = products.sum do |product|
    product.price * cart[product.id.to_s].to_i
  end

  @order = current_user.orders.create!(
    total: total,
    payment_status: "pending",
    status: "order_pending"
  )

  products.each do |product|
    @order.order_items.create!(
      product: product,
      quantity: cart[product.id.to_s].to_i,
      price: product.price
    )
  end

  # ⭐ CREATE RAZORPAY ORDER
  razorpay_order = Razorpay::Order.create(
    amount: (@order.total * 100).to_i,
    currency: "INR",
    receipt: "order_#{@order.id}"
  )

  @order.update(razorpay_order_id: razorpay_order.id)

  session[:cart] = {}

  redirect_to @order
end
  def payment_success
    order = Order.find_by(razorpay_order_id: params[:razorpay_order_id])

    if order.present?
      order.update(
        payment_id: params[:razorpay_payment_id],
        payment_status: "paid"
      )
    end

    redirect_to order_path(order)
  end


  # Order confirmation page
  def show
    @order = current_user.orders.find(params[:id])
  end
end
