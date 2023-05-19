class ReviewsController < ApplicationController
  def new
    @review = Review.new
    @kitchen = Kitchen.find(params[:kitchen_id])
    authorize @review
  end

  def create
    @kitchen = Kitchen.find(params[:kitchen_id])
    @review = Review.new(review_params)
    @review.kitchen = @kitchen
    @review.user = current_user
    authorize @review
    if @review.save
      flash[:success] = "Review created successfully!"
      redirect_to kitchen_path(@kitchen)
    else
      flash[:error] = "Review could not be created"
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def review_params
    params.require(:review).permit(:content)
  end
end
