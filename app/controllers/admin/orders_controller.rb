class Admin::OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin

  def index
    @orders = Order.order(created_at: :desc)
  end

  def show
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])

    if @order.update(status: params[:order][:status])
      redirect_to admin_order_path(@order), notice: "Order updated"
    else
      render :show
    end
  end

  private

  def require_admin
    redirect_to root_path, alert: "Access denied (admin only)" unless current_user.admin?
  end
end
