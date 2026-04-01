class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product

  def create
    @review = @product.reviews.build(review_params)
    @review.user = current_user

    if @review.save
      redirect_to @product, notice: "Review added successfully."
    else
      redirect_to @product, alert: @review.errors.full_messages.join(", ")
    end
  end

  def destroy
    @review = @product.reviews.find(params[:id])

    if @review.user == current_user
      @review.destroy
      redirect_to @product, notice: "Review deleted."
    else
      redirect_to @product, alert: "Not authorized."
    end
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end

  def review_params
    params.require(:review).permit(:rating, :comment)
  end
end