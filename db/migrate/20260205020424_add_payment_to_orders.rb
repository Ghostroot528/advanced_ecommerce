class AddPaymentToOrders < ActiveRecord::Migration[8.1]
  def change
    add_column :orders, :razorpay_order_id, :string
    add_column :orders, :payment_id, :string
    add_column :orders, :payment_status, :string
  end
end
