class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy

  enum :payment_status, {
    pending: "pending",
    paid: "paid"
  }

  enum :status, {
    order_pending: "pending",
    shipped: "shipped",
    delivered: "delivered"
  }
end
