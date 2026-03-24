class ProductsController < ApplicationController
  def index
    @categories = Category.all

    if params[:category].present?
      @products = Product.where(category_id: params[:category]).page(params[:page]).per(6)
    elsif params[:search].present?
      @products = Product.where("name ILIKE ?", "%#{params[:search]}%").page(params[:page]).per(6)
    else
      @products = Product.page(params[:page]).per(6)
    end
  end

  def show
    @product = Product.find(params[:id])
  end
end
