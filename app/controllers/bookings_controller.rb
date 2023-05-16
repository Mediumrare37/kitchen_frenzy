class BookingsController < ApplicationController
  def create
    @kitchen = Kitchen.find(params[:kitchen_id])
    @booking = @kitchen.bookings.build(booking_params)
    if @booking.save
      redirect_to confirmation_path
    else
      render 'error'
      puts "Sorry, there was an error"
    end
  end

  def index
    @bookings = Booking.where(chef_id: current_chef.id).order(start_date: :desc)
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :guests)
  end
end
