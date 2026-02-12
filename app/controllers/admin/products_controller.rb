class Admin::ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to admin_products_path, notice: "Product created"
    else
      render :new
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :category_id, images: [])
  end
end
