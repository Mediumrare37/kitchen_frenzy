class Owner::BookingsController < ApplicationController
  def index
    @bookings = Booking.where(owner_id: current_owner.id).order(start_date: :desc)
  end

  def create
    @kitchen = Kitchen.find(params[:kitchen_id])
    @booking = @kitchen.bookings.build(booking_params)

    if @booking.save
      redirect_to confirmation_path
    else
      render 'Admin error'
      puts "Please contact your admin"
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :guests)
  end
end
