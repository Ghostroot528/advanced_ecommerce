class Admin::OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin

  def index
    @orders = Order.includes(:user).order(created_at: :desc)
  end

  def show
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    @order.update(status: params[:status])
    redirect_to admin_order_path(@order), notice: "Order status updated"
  end

  private

  def require_admin
    redirect_to root_path, alert: "Access denied (admin only)" unless current_user.admin?
  end
end
