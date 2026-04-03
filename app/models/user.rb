class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders
  has_many :reviews, dependent: :destroy

  has_many :wishlists, dependent: :destroy
  has_many :wishlist_products, through: :wishlists, source: :product

  # admin? (boolean check) → returns true or false
  def admin?
    admin == true
  end
end
