class CartController < ApplicationController
  def show
    @cart = session[:cart] || {}
    @products = Product.where(id: @cart.keys)
  end

  def add
    session[:cart] ||= {}
    product_id = params[:product_id].to_s
    session[:cart][product_id] ||= 0
    session[:cart][product_id] += 1
    redirect_to cart_path
  end

  def remove
    session[:cart]&.delete(params[:product_id].to_s)
    redirect_to cart_path
  end
end
