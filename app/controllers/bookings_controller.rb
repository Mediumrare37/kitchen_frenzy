class BookingsController < ApplicationController
  def create
    @kitchen = Kitchen.find(params[:kitchen_id])
    @booking = Booking.new(booking_params)
    @booking.kitchen = @kitchen
    @booking.user = current_user
    if @booking.save
      flash[:success] = "Booked successfully!"
      redirect_to @kitchen
    else
      flash[:error] = "Booking could not be created"
      redirect_back(fallback_location: root_path)
    end
    authorize @booking
  end

  def index
    @bookings = policy_scope(Booking).where(user_id: current_user.id).order(start_date: :desc)
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :guests)
  end
end
