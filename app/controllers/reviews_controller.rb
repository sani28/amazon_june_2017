class ReviewsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :destroy, :update]

  def create
    @review = Review.new(review_params)
    @product = Product.find(params[:product_id])
    @review.product = @product
    @review.user = current_user

    if @review.save
      redirect_to @product, notice: 'Review Successfully Created!'
    else
      flash[:alert] = 'Review not created'
      render '/products/show'
    end
  end

  def destroy
    @review = Review.find(params[:id])

    if @review.destroy
      redirect_to product_path(params[:product_id]), notice: 'Review Deleted!'
    else
      redirect_to product_path(params[:product_id]), alert: 'Review NOT Deleted!'
    end
  end

  def edit
    @review  = Review.find(params[:id])
    @product = Product.find(params[:product_id])
  end

  def update
    @review  = Review.find(params[:id])
    @product = Product.find(params[:product_id])

    if @review.update(review_params)
      flash[:notice] = 'Review successfully updated.'
      redirect_to product_path(@product)
    else
      flash.now[:alert] = 'Error updating review'
      render '/products/show'
    end
  end

  private

  def review_params
    params.require(:review).permit(:body, :rating)
  end

  def authorize_user!
    unless can?(:manage, @review)
    head :unauthorized
  end
end

end
