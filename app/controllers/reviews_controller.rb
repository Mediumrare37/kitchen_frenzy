class ReviewsController < ApplicationController
  def create
    @booking = Booking.find(params[:booking_id])
    @review = Review.new(review_params)
    @review.booking = @booking
    @review.user = current_user

    if @review.save
      flash[:success] = "Review created successfully!"
      redirect_to @booking
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
