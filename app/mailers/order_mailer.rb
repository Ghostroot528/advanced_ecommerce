class OrderMailer < ApplicationMailer
  default from: "no-reply@advancedecommerce.com"

  def order_confirmation(order)
    @order = order
    mail(to: @order.user.email, subject: "Order Confirmation ##{@order.id}")
  end

  def admin_notification(order)
    @order = order
    mail(to: "admin@advancedecommerce.com", subject: "New Order Received ##{@order.id}")
  end
end