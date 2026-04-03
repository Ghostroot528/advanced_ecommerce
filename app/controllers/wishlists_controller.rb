class WishlistsController < ApplicationController
  before_action :authenticate_user!

  def index
    @wishlist_items = current_user.wishlist_products
  end

  def create
    product = Product.find(params[:product_id])
    current_user.wishlists.create(product: product)

    redirect_back fallback_location: root_path, notice: "Added to wishlist ❤️"
  end

  def destroy
    wishlist = current_user.wishlists.find_by(product_id: params[:id])
    wishlist&.destroy

    redirect_back fallback_location: wishlists_path, notice: "Removed from wishlist ❌"
  end
end
